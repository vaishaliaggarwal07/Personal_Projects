const {
    generateAccountSASQueryParameters,
    AccountSASPermissions,
    AccountSASServices,
    AccountSASResourceTypes,
    StorageSharedKeyCredential,
    SASProtocol,
    BlobServiceClient
} = require('@azure/storage-blob');
const {uuid} = require('uuidv4');
const {ManagedIdentityCredential, DefaultAzureCredential} = require('@azure/identity');
const {
    AzureMediaServices,
} = require('@azure/arm-mediaservices');

const util = require('util');

const constants = {
    accountName: process.env.AZURE_STORAGE_ACCOUNT_NAME,
    accountKey: process.env.AZURE_STORAGE_ACCOUNT_KEY,
    containerName: process.env.AZURE_BLOB_UPLOAD_CONTAINER_NAME,
};
if (!constants.accountName) {
    throw new Error('No azure storage account name in env');
}
if (!constants.accountKey) {
    throw new Error('No azure storage account key name in env');
}
const sharedKeyCredential = new StorageSharedKeyCredential(
    constants.accountName,
    constants.accountKey
);

// IMP Tutorial taken from https://github.com/Azure-Samples/media-services-v3-node-tutorials/blob/main/Streaming/StreamFilesSample/index.ts#L59
// This is the main Media Services client object


// Copy the samples.env file and rename it to .env first, then populate it's values with the values obtained
// from your Media Services account's API Access page in the Azure portal.
const subscriptionId = process.env.AZURE_SUBSCRIPTION_ID;
const resourceGroup = process.env.AZURE_RESOURCE_GROUP;
const accountName = process.env.AZURE_MEDIA_SERVICES_ACCOUNT_NAME;

// const credential = new ManagedIdentityCredential(process.env.AZURE_MANAGED_IDENTITY_CLIENT_ID);
const credential = new DefaultAzureCredential();

const timeoutSeconds = 60 * 10;
const sleepInterval = 1000 * 2;
const setTimeoutPromise = util.promisify(setTimeout);
const namePrefix = "stream";
const encodingTransformName = "ContentAwareEncoding";

const mediaServicesClient = new AzureMediaServices(credential, subscriptionId);

const blobServiceUri = `https://${constants.accountName}.blob.core.windows.net`;

// let inputUrl = '';

async function startEncodingAndGetStreamingURLToStore(movieObject, isMovie) {
    let inputUrl;
    try {
        if (!movieObject) {
            throw new Error('No movie object passed')
        }

        if (isMovie) {
            if(!movieObject.movieUploadedUrl){
                throw new Error('No movie upload url')
            }
            inputUrl = movieObject.movieUploadedUrl + '?' + createAccountSAS('r').sasToken;
        } else {
            if(!movieObject.trailerUploadedUrl){
                throw new Error('No trailer upload url')
            }
            inputUrl = movieObject.trailerUploadedUrl + '?' + createAccountSAS('r').sasToken;
        }
        let uniqueness = uuid();
        let jobInput = {
            odataType: "#Microsoft.Media.JobInputHttp",
            files: [inputUrl]
        };
        let outputAssetName = `${namePrefix}-output-${uniqueness}`;
        let jobName = `${namePrefix}-job-${uniqueness}`;
        let locatorName = `locator${uniqueness}`;

        console.log("Creating the output Asset to encode content into...");
        await updateStatesInMovieObject(movieObject, isMovie, 'Creating Assets');
        let outputAsset = await mediaServicesClient.assets.createOrUpdate(resourceGroup, accountName, outputAssetName, {});

        let movieSubObject;
        if (isMovie) {
            movieSubObject = movieObject.azureMovieEncodingDetails;
        } else {
            movieSubObject = movieObject.azureTrailerEncodingDetails;
        }
        if (outputAsset.name !== undefined) {
            movieSubObject.outputAssetName = outputAsset.name;
            movieSubObject.locatorName = locatorName;
            movieSubObject.jobName = jobName;
            movieSubObject.encodingTransformName = encodingTransformName;
            await updateStatesInMovieObject(movieObject, isMovie, 'Starting Transform job');

            console.log("Submitting the encoding job to the Transform's job queue...");
            let job = await submitJob(encodingTransformName, jobName, jobInput, outputAsset.name);

            console.log(`Waiting for Job - ${job.name} - to finish encoding`);
            job = await waitForJobToFinish(encodingTransformName, jobName, movieObject, isMovie);

            if (job.state === "Finished") {
                console.log('azureService:testMain: encoding job finished ', job);
                // await downloadResults(outputAsset.name as string, outputFolder);
                await updateStatesInMovieObject(movieObject, isMovie, 'creating stream locator');
                let locator = await createStreamingLocator(outputAsset.name, locatorName);
                movieSubObject.locatorName = locator.name;
                await updateStatesInMovieObject(movieObject, isMovie, 'Stream locator created');
                if (locator.name !== undefined) {
                    let urls = await getStreamingUrls(locator.name, movieObject, isMovie);
                } else {
                    throw new Error("Locator was not created or Locator.name is undefined");
                }
            }
        } else {
            await updateStatesInMovieObject(movieObject, isMovie, 'Assets creation failed');
        }

    } catch (e) {
        await updateStatesInMovieObject(movieObject, isMovie, 'FAILED - ', e.message);
        console.log('azureService:startEncodingAndGetStreamingURLToStore: isMovie ', isMovie, ' inputUrl ', inputUrl);
        console.error('azureService:startEncodingAndGetStreamingURLToStore: ', e);
    }
}

// one time setup
async function createTransformIfNotExist() {

    // Ensure that you have the desired encoding Transform. This is really a one time setup operation.
    console.log("Creating encoding transform...");

    // Create a new Transform using a preset name from the list of builtin encoding presets.
    // To use a custom encoding preset, you can change this to be a StandardEncoderPreset, which has support for codecs, formats, and filter definitions.
    // This sample uses the 'ContentAwareEncoding' preset which chooses the best output based on an analysis of the input video.
    let adaptiveStreamingTransform = createBuiltInStandardEncoderPreset({
        presetName: encodingTransformName
    });

    let encodingTransform = await mediaServicesClient.transforms.createOrUpdate(resourceGroup, accountName, encodingTransformName, {
        name: encodingTransformName,
        outputs: [
            {
                preset: adaptiveStreamingTransform
            }
        ]
    });
    console.log("Transform Created (or updated if it existed already).", encodingTransform);
}

function createBuiltInStandardEncoderPreset(builtInStandardEncoder) {
    return {
        odataType: "#Microsoft.Media.BuiltInStandardEncoderPreset",
        ...builtInStandardEncoder,
    }
}

async function submitJob(transformName, jobName, jobInput, outputAssetName) {
    if (!outputAssetName) {
        throw new Error("OutputAsset Name is not defined. Check creation of the output asset");
    }
    let jobOutputs = [{
        odataType: "#Microsoft.Media.JobOutputAsset",
        assetName: outputAssetName
    }];

    return mediaServicesClient.jobs.create(resourceGroup, accountName, transformName, jobName, {
        input: jobInput,
        outputs: jobOutputs
    });

}

async function waitForJobToFinish(transformName, jobName, movieObject, isMovie) {
    let timeout = new Date();
    timeout.setSeconds(timeout.getSeconds() + timeoutSeconds);

    async function pollForJobStatus() {
        let job = await mediaServicesClient.jobs.get(resourceGroup, accountName, transformName, jobName);
        await updateStatesInMovieObject(movieObject, isMovie, 'Job State - ' + job.state);
        if (job.state == 'Finished' || job.state == 'Error' || job.state == 'Canceled') {
            if (job.state === 'Error') {
                console.log('azureService:pollForJobStatus: job ', job);
            }
            return job;
        } else if (new Date() > timeout) {
            await updateStatesInMovieObject(movieObject, isMovie, 'Job State - timed out');
            console.log(`Job ${job.name} timed out. Please retry or check the source file.`);
            return job;
        } else {
            await setTimeoutPromise(sleepInterval, null);
            return pollForJobStatus();
        }
    }

    return await pollForJobStatus();
}

async function checkForJobStatusAndResubmit(movieObject, isMovie,reRunJob=true) {
    let  transformName;
    let jobName;
    let jobExists = true;
    if(isMovie){
        if(movieObject?.azureMovieEncodingDetails?.encodingTransformName){
            transformName = movieObject.azureMovieEncodingDetails.encodingTransformName;
            jobName = movieObject.azureMovieEncodingDetails.jobName;
        }else{
            jobExists = false;
        }
    }else{
        if(movieObject?.azureTrailerEncodingDetails?.encodingTransformName){
            transformName = movieObject.azureTrailerEncodingDetails.encodingTransformName;
            jobName = movieObject.azureTrailerEncodingDetails.jobName;
        }else{
            jobExists = false
        }
    }
    let job;
    if(jobExists){
        job = await mediaServicesClient.jobs.get(resourceGroup, accountName, transformName, jobName);
        await updateStatesInMovieObject(movieObject, isMovie, 'Job State - ' + job.state);
        console.log('azureService:pollForJobStatus: job ', job);
    }
    if (reRunJob && (!job || (job && job.state !== 'Finished'))) {
        await startEncodingAndGetStreamingURLToStore(movieObject,isMovie);
    }
}

async function createStreamingLocator(assetName, locatorName) {
    let streamingLocator = {
        assetName: assetName,
        streamingPolicyName: "Predefined_ClearStreamingOnly"  // no DRM or AES128 encryption protection on this asset. Clear means unencrypted.
    };

    let locator = await mediaServicesClient.streamingLocators.create(
        resourceGroup,
        accountName,
        locatorName,
        streamingLocator);

    return locator;
}

async function getStreamingUrls(locatorName, movieObject, isMovie) {
    console.log('azureService:getStreamingUrls: ');
    // Make sure the streaming endpoint is in the "Running" state on your account
    let streamingEndpoint = await mediaServicesClient.streamingEndpoints.get(resourceGroup, accountName, "default");

    let paths = await mediaServicesClient.streamingLocators.listPaths(resourceGroup, accountName, locatorName);
    if (paths.streamingPaths) {
        movieObject.azureStreamingEndPointHostName = streamingEndpoint.hostName
        let videoPaths = [];
        paths.streamingPaths.forEach(path => {
            console.log('azureService:path: ', path);
            path.paths?.forEach(formatPath => {
                let manifestPath = "https://" + streamingEndpoint.hostName + formatPath;
                videoPaths.push(manifestPath);
                console.log(manifestPath);
            });
        });
        if (isMovie) {
            movieObject.movieUrl = videoPaths;
        } else {
            movieObject.trailerUrl = videoPaths;
        }
        await updateStatesInMovieObject(movieObject, isMovie, 'Job State - Finished');
    } else {
        await updateStatesInMovieObject(movieObject, isMovie, 'Unable to get streaming locator');
    }
}

async function checkIfContainerExistsElseCreate(containerName) {
    try {
        const blobServiceClient = new BlobServiceClient(
            `${blobServiceUri}?${createAccountSAS().sasToken}`,
            null
        );
        const containerClient = await blobServiceClient.getContainerClient(containerName);
        const isContainerExists = await containerClient.exists()
        if (!isContainerExists) {
            console.log(`azureService:checkIfContainerExistsElseCreate: CONTAINER DOESN'T EXISTS, CREATING ... ${containerName}`);
            const createResponse = await containerClient.create();
            console.log(`azureService:checkIfContainerExistsElseCreate: CREATED ${containerName} ,Response `, createResponse);
        }
    } catch (e) {
        console.error('azureService:checkIfContainerExistsElseCreate: unable to create container ', e);
        console.error('azureService:checkIfContainerExistsElseCreate: EXITING SERVER ');
        process.exit(0);
    }
}

// checkIfContainerExistsElseCreate(constants.containerName);
// createTransformIfNotExist()

function createAccountSAS(permission) {
    // permission explanations https://learn.microsoft.com/en-us/rest/api/storageservices/create-service-sas#permissions-for-a-directory-container-or-blob
    const sasOptions = {
        services: AccountSASServices.parse("bf").toString(),          // blobs, tables, queues, files
        permissions: AccountSASPermissions.parse(permission),          // permissions
        resourceTypes: AccountSASResourceTypes.parse("co").toString(), // service, container, object
        protocol: SASProtocol.Https,
        startsOn: new Date(),
        expiresOn: new Date(new Date().valueOf() + (10 * 60 * 1000)),   // 10 minutes
    };

    let sasToken
    try {
        sasToken = generateAccountSASQueryParameters(
            sasOptions,
            sharedKeyCredential
        ).toString();
    } catch (e) {
        console.error('azureService:createAccountSAS: ', e);
        throw e
    }

    return {
        sasToken,
        containerName: constants.containerName,
        accountName: constants.accountName,
        blobServiceUri,
    };
    // prepend sasToken with `?`
}


async function updateStatesInMovieObject(movieObject, isMovie, statusMessage) {
    if (isMovie) {
        movieObject.azureMovieEncodingDetails.encodingStatus = statusMessage;
    } else {
        movieObject.azureTrailerEncodingDetails.encodingStatus = statusMessage;
    }
    await movieObject.save();
}

function appendSASToBanner(movie) {
    if (movie && movie.banners && movie.banners.length > 0) {
        let bannerList = []
        for (let banner of movie.banners) {
            // because of cyclic call using ref keyword token is appended twice
            if (banner.includes('windows.net') && !banner.includes('?sv=')) {
                bannerList.push(banner + '?' + createAccountSAS('r').sasToken)
            } else {
                bannerList.push(banner);
            }
        }
        movie.banners = bannerList;
    }
}

function appendSASToField(object,fieldName){
    if(object && object[fieldName]){
        if(object[fieldName].includes('windows.net') && !object[fieldName].includes('?sv=')){
            object[fieldName] = object[fieldName]+ '?' + createAccountSAS('r').sasToken
        }
    }
}

module.exports = {
    createAccountSAS,
    appendSASToBanner,
    appendSASToField,
    startEncodingAndGetStreamingURLToStore,
    checkForJobStatusAndResubmit
}
