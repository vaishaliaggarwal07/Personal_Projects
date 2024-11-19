/*
var AWS = require("aws-sdk");
// const { S3Client, AbortMultipartUploadCommand } = require("@aws-sdk/client-s3");
const constants = require("./../utils/constants.json");

AWS.config.loadFromPath("./config/awsconfig.json");
const s3 = new AWS.S3();
const cloudfront = new AWS.CloudFront();
const mediaconvert = new AWS.MediaConvert({
  endpoint: constants.MediaConverter_EndPoint,
}); //({ endpoint: "https://vasjpylpa.mediaconvert.us-east-1.amazonaws.com" })

const getBucketList = async () => {
  let list = await s3.listBuckets().promise();
  let details = await s3.getObject({ Bucket: "dhaakadmovies" }).promise();
  console.log(list);
  console.log(details);
  return list;
};

const createBucket = async (bucket) => {
  var bucketParams = {
    Bucket: bucket,
    ACL: "public-read",
  };
  let created = await s3.createBucket(bucketParams).promise();
  console.log(created);
};

const getBucketDetails = async (bucket) => {
  var bucketParams = {
    Bucket: bucket,
    MaxKeys: 10,
  };
  let list = await s3.listObjects({ Bucket: bucket }).promise();
  //   console.log(list);
  return list;
};

const uploadFileToBucket = async (
  bucket,
  subfolder,
  fileContent,
  fileName,
  isPromise = null
) => {
  const params = {
    Bucket: bucket,
    Key: subfolder + fileName,
    Body: fileContent,

    // Option: { mute: false  },
    // ACL: 'public-read',
  };

  return isPromise ? s3.upload(params).promise() : s3.upload(params);
  //   console.log(created);
  return created;
  // return new Promise(async (resolve)=>{
  //     let created = await s3.upload(params).promise();
  //     resolve(created)
  // })
};

const getStreamUrl = async (videoUrl, folder) => {
  // console.log(constants.Bucket_s3_Path_s3 + videoUrl, folder);
  return await mediaconvert
    .createJob({
      Role: constants.MediaConverter_Role_ARN, // "arn:aws:iam::232321253042:role/service-role/MediaConvert_Default_Role",
      // UserMetadata: {
      //     Customer: "Amazon"
      // },
      Settings: {
        Inputs: [
          {
            FileInput: constants.Bucket_s3_Path_s3 + folder + videoUrl,
          },
        ],
        OutputGroups: [
          {
            Name: "Stream" + videoUrl,
            Outputs: [
              {
                NameModifier: "_modifier",
                ContainerSettings: { Container: "M3U8" },
                VideoDescription: {
                  CodecSettings: {
                    Codec: "H_264",
                    H264Settings: {
                      InterlaceMode: "PROGRESSIVE",
                      NumberReferenceFrames: 3,
                      Syntax: "DEFAULT",
                      Softness: 0,
                      GopClosedCadence: 1,
                      GopSize: 90,
                      Slices: 1,
                      GopBReference: "DISABLED",
                      SlowPal: "DISABLED",
                      SpatialAdaptiveQuantization: "ENABLED",
                      TemporalAdaptiveQuantization: "ENABLED",
                      FlickerAdaptiveQuantization: "DISABLED",
                      EntropyEncoding: "CABAC",
                      Bitrate: 5000000,
                      FramerateControl: "SPECIFIED",
                      RateControlMode: "CBR",
                      CodecProfile: "MAIN",
                      Telecine: "NONE",
                      MinIInterval: 0,
                      AdaptiveQuantization: "HIGH",
                      CodecLevel: "AUTO",
                      FieldEncoding: "PAFF",
                      SceneChangeDetect: "ENABLED",
                      QualityTuningLevel: "SINGLE_PASS",
                      FramerateConversionAlgorithm: "DUPLICATE_DROP",
                      UnregisteredSeiTimecode: "DISABLED",
                      GopSizeUnits: "FRAMES",
                      ParControl: "SPECIFIED",
                      NumberBFramesBetweenReferenceFrames: 2,
                      RepeatPps: "DISABLED",
                      FramerateNumerator: 30,
                      FramerateDenominator: 1,
                      ParNumerator: 1,
                      ParDenominator: 1,
                    },
                  },
                },

                // CaptionDescriptions: [{
                //     CaptionSelectorName: "Caption Selector",
                //     LanguageCode: "ENG",
                //     DestinationSettings: {
                //         DestinationType: "BURN_IN"
                //     }

                // }],
                OutputSettings: {
                  HlsSettings: {
                    SegmentModifier: "_segmentModifier",
                  },
                },
              },
            ],
            OutputGroupSettings: {
              Type: "HLS_GROUP_SETTINGS", // "HLS_GROUP_SETTINGS"|"DASH_ISO_GROUP_SETTINGS"|"FILE_GROUP_SETTINGS"|"MS_SMOOTH_GROUP_SETTINGS"|"CMAF_GROUP_SETTINGS"|

              HlsGroupSettings: {
                Destination:
                  constants.Bucket_s3_Path_s3 + folder + "/streamUrls/",
                SegmentLength: 1,
                MinSegmentLength: 1,
              },
              // CmafGroupSettings:{

              // }
            },
          },
        ],
      },
    })
    .promise();
};

module.exports = {
  s3,
  cloudfront,
  mediaconvert,
  createBucket,
  getBucketList,
  uploadFileToBucket,
  getStreamUrl,
  getBucketDetails,
};
*/
