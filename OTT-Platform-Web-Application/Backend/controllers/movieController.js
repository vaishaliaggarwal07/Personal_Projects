const Movie = require("./../models/movieModel");
const APIFeatures = require("./../utils/apiFeatures");
const catchAsync = require("./../utils/catchAsync");
const AppError = require("./../utils/appError");
const multer = require("multer");

const {
    preBookedMoviesValidations,
} = require("./../utils/validations/movieValidation");

const User = require("../models/userModel");
const MovieTranscations = require("../models/movieTrasncations");
const {createAccountSAS, startEncodingAndGetStreamingURLToStore,checkForJobStatusAndResubmit} = require('../service/azureService');

const multerStorage = multer.memoryStorage();

const multerFilter = (req, file, cb) => {
    if (
        file.mimetype.startsWith("image") ||
        file.mimetype.startsWith("video") ||
        file.mimetype.includes("text/vtt")
    ) {
        cb(null, true);
    } else {
        cb(
            new AppError(
                "Not an image or video! Please upload only images or video.",
                400
            ),
            false
        );
    }
};

const upload = multer({
    storage: multerStorage,
    fileFilter: multerFilter,
});

exports.uploadMovieImages = upload.fields([
    {name: "banners", maxCount: 5},
    {name: "movieVideo", maxCount: 1},
    {name: "trailerVideo", maxCount: 1},
    {name: "subtitles", maxCount: 5},
    {name: "video", maxCount: 1},
]);

exports.aliasTopMovies = (req, res, next) => {
    req.query.limit = "5";
    req.query.sort = "-ratingsAverage,price";
    req.query.fields = "name,price,ratingsAverage,summary,difficulty";
    next();
};

exports.getTrendMovies = catchAsync(async (req, res, next) => {
    let query = {isTrend: true};

    const trendMovies = new APIFeatures(Movie.find(), query)
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const movies = await trendMovies.query;

    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Movies fetched successfully",
        results: movies.length,
        data: {
            movies,
        },
    });
});

exports.getPreBookedMovies = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.params.userid);

    if (!user) {
        return next(new AppError("No user found with that ID", 404));
    }

    const {error} = preBookedMoviesValidations(req.params);
    if (error) {
        return next(new AppError(error.details[0].message, 400));
    }

    const transMovies = new APIFeatures(MovieTranscations.find(), {
        userId: req.params.userid,
        movie_booking_type: "PREBOOK | BOOK | RENT",
    })
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const transcations = await transMovies.query;

    let moviesIds = [];

    transcations.map((t) => {
        moviesIds.push(t.movieId);
    });

    const query = {_id: {$in: moviesIds}};
    const allmovie = await Movie.find(query);
    Movie.find;

    // const allmovie = await movies.query;
    // console.log(allmovie)

    //User.updateOne
    // SEND RESPONSE
    res.status(200).json({
        status: "Success",
        message: "Prebooked Movies are here",
        results: allmovie,
    });
});

exports.getRentMovies = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.params.userid);

    if (!user) {
        return next(new AppError("No user found with that ID", 404));
    }

    const {error} = preBookedMoviesValidations(req.params);
    if (error) {
        return next(new AppError(error.details[0].message, 400));
    }

    const transMovies = new APIFeatures(MovieTranscations.find(), {
        userId: req.params.userid,
    })
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const transcations = await transMovies.query;

    let moviesIds = [];

    transcations.map((t) => {
        moviesIds.push(t.movieId);
    });

    const query = {_id: {$in: moviesIds}};
    const allmovie = await Movie.find(query);
    Movie.find;

    // const allmovie = await movies.query;
    // console.log(allmovie)

    //User.updateOne
    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Rent  Movies are here!",
        results: allmovie,
    });
});

exports.getPurcheMovies = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.params.userid);

    if (!user) {
        return next(new AppError("No user found with that ID", 404));
    }

    const {error} = preBookedMoviesValidations(req.params);
    if (error) {
        return next(new AppError(error.details[0].message, 400));
    }
    const transMovies = new APIFeatures(MovieTranscations.find(), {
        userId: req.params.userid,
    })
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const transcations = await transMovies.query;

    let moviesIds = [];

    transcations.map((t) => {
        moviesIds.push(t.movieId);
    });

    const query = {_id: {$in: moviesIds}};
    const allmovie = await Movie.find(query);
    Movie.find;

    // const allmovie = await movies.query;
    // console.log(allmovie)

    //User.updateOne
    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Purchase Movies are here!",
        results: allmovie,
    });
});

exports.getComingMovies = catchAsync(async (req, res, next) => {
    let query = {releaseDate: {gte: new Date()}};

    const trendMovies = new APIFeatures(Movie.find(), query)
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const movies = await trendMovies.query;

    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Movies fetched successfully!",
        results: movies.length,
        data: {
            movies,
        },
    });
});

exports.getStreamMovies = catchAsync(async (req, res, next) => {
    let query = {releaseDate: {gte: new Date()}};

    const trendMovies = new APIFeatures(Movie.find(), query)
        .filter()
        .sort()
        .limitFields()
        .paginate();

    let expired = false;
    if (expired == true) {
        setTimeout(() => {
            return "Movie has been expired";
        }, 8000);
    }

    const movies = await trendMovies.query;

    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Stream Movies fetched successfully!!",
        result: movies.length,
        data: {
            movies,
        },
    });
});

exports.getRecentlyAdded = catchAsync(async (req, res, next) => {
    let query = {movieVideo: {$exists: true, $ne: "", $ne: null}, limit: 10};
    const recentMovies = new APIFeatures(Movie.find(), query)
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const movies = await recentMovies.query;

    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Movies fetched successfully!",
        results: movies.length,
        data: {
            movies,
        },
    });
});

exports.getAllMovies = catchAsync(async (req, res, next) => {
    let query = {};
    let feature = [];
    if (req.query["language"]) {
        query["languages"] = req.query["language"].split(",");
    }

    if (req.query.page && req.query.limit) {
        query["page"] = req.query.page;
        query["limit"] = req.query.limit;
        console.log(query);
    }

    if (req.query["categories"]) {
        query["categories"] = req.query["categories"].split(",");
        console.log(query["categories"]);
    }

    if (req.query["feature"]) {
        query =
            req.query["feature"].toLowerCase() == "yes"
                ? {isFeatured: true}
                : req.query["feature"].toLowerCase() == "no"
                    ? {isFeatured: false}
                    : {};
        if (query.isFeatured == true) {
            let featuredMovies = new APIFeatures(Movie.find(), query)
                .filter()
                .sort()
                .limitFields()
                .paginate();
            feature = await featuredMovies.query;
        }
        delete query.isFeatured;
    }

    if (req.query["search"]) {
        query.title = {$regex: req.query["search"]};
    }

    const allMovies = new APIFeatures(Movie.find(), query)
        .filter(10, 5)
        .sort()
        .limitFields()
        .paginate();

    // const feature = await featuredMovies.query;
    const movies = await allMovies.query;

    //   await movies.map(async (m) => {

    //     reviewquery = { movieId: m.id }

    //     const reviews = await Review.find({ movieId: m.id })

    //     totalReview = reviews
    //     // console.log(totalReview)
    //     // m['totalReviewsCount'] = totalReview.length
    //     // const mdata = await Movie.updateOne({id:m.id }, {$set:{totalReviewsCount:totalReview.length}})
    //     const mdata = await  Movie.findByIdAndUpdate(m.id, {totalReviewsCount:totalReview.length})
    //     console.log(mdata)
    // //62495dccfa2ad6ac40d75764
    //     // console.log(totalReview.length)
    //   })

    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Movies fetched successfully",
        results: movies.length + feature.length,
        data: {
            movies,
            feature,
        },
    });
});

exports.getMovie = catchAsync(async (req, res, next) => {
    const movie = await Movie.findById(req.params.id);
    // Movie.findOne({ _id: req.params.id })

    if (!movie) {
        return next(new AppError("No movie found with that ID", 404));
    }

    res.status(200).json({
        status: "success",
        message: "Movie fetched successfully",
        data: {
            movie,
        },
    });
});

exports.createMovie = catchAsync(async (req, res, next) => {
    console.log(req.body);
    //Validate Data
    // const { error } = addMovieValidation(req.body);
    // if (error) return next(new AppError(error.details[0].message, 400));

    req.body.languages = req.body.languages.split(",");
    req.body.categories = req.body.categories.split(",");
    req.body.castIds = req.body.castIds.split(",");
    req.body.casts = req.body.casts.split(",");
    req.body.ageGroup = req.body.ageGroup.split(",");
    // req.body.subtitles = req.body.subtitles.split(",");
    // req.body.banners = req.body.banners.split(",");

    const reqBody = req.body;
    req.body.banners =req.body.banners.split(',');

    const newMovie = await Movie.create(req.body);

    res.status(201).json({
        status: "success",
        message: "Movie created successfully!",
        data: {
            movie: newMovie,
        },
    });

    try {
        // start the encoding process
        const movieId = newMovie.id;
        const movieObj = await Movie.findById(movieId);
        await startEncodingAndGetStreamingURLToStore(movieObj, true);
        const trailerObj = await Movie.findById(movieId);
        await startEncodingAndGetStreamingURLToStore(trailerObj, false);

    } catch (e) {
        console.error('movieController:encoding err: ', e);
    }
});

exports.updateMovie = catchAsync(async (req, res, next) => {
    //Validate Data
    // const { error } = updateMovieValidation(req.body);

    // if (error) return next(new AppError(error.details[0].message, 400));

    const movie = await Movie.findById(req.params.id);
    if (!movie) {
        return next(new AppError("No movie found with that ID", 404));
    }
    const updates = Object.keys(req.body);
    updates.forEach((update) => {
        if(update !== 'banners' || update !== 'movieUrl' || update !=='trailerUrl'){
            if (req.body[update].includes(",")) {
                movie[update] = req.body[update].split(",");
            } else {
                movie[update] = req.body[update];
            }
        }
    });
    await movie.save();

    res.status(200).json({
        status: "success",
        message: "Movie updated successfully",
        data: {
            movie,
        },
    });
});

exports.deleteMovie = catchAsync(async (req, res, next) => {
    const movie = await Movie.findByIdAndDelete(req.params.id);

    if (!movie) {
        return next(new AppError("No movie found with that ID", 404));
    }

    res.status(200).json({
        status: "success",
        data: null,
    });
});


exports.getMovieStats = catchAsync(async (req, res, next) => {
    const stats = await Movie.aggregate([
        {
            $match: {ratingsAverage: {$gte: 4.5}},
        },
        {
            $group: {
                _id: {$toUpper: "$difficulty"},
                numMovies: {$sum: 1},
                numRatings: {$sum: "$ratingsQuantity"},
                avgRating: {$avg: "$ratingsAverage"},
                avgPrice: {$avg: "$price"},
                minPrice: {$min: "$price"},
                maxPrice: {$max: "$price"},
            },
        },
        {
            $sort: {avgPrice: 1},
        },
        // {
        //   $match: { _id: { $ne: 'EASY' } }
        // }
    ]);

    res.status(200).json({
        status: "success",
        message: "Movies fetched successfully",
        data: {
            stats,
        },
    });
});
//
//
exports.updateStream = catchAsync(async (req, res, next) => {
    const movie = await Movie.findByIdAndUpdate(req.params.movieid, req.body);

    if (!movie) {
        return next(new AppError("No movie found with that ID", 404));
    }

    const transMovies = new APIFeatures(MovieTranscations.find(), {
        movieId: req.params.movieid,
    })
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const transcations = await transMovies.query;

    let moviesIds = [];

    transcations.map((t) => {
        moviesIds.push(t.movieId);
    });

    const query = {_id: {$in: moviesIds}};
    const movieData = await Movie.find(query);
    Movie.find;

    // const allmovie = await movies.query;
    // console.log(allmovie)

    //User.updateOne
    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Rent  Movies are here!",
        results: movieData,
    });
});
//

exports.getMonthlyPlan = catchAsync(async (req, res, next) => {
    const year = req.params.year * 1; // 2021

    const plan = await Movie.aggregate([
        {
            $unwind: "$startDates",
        },
        {
            $match: {
                startDates: {
                    $gte: new Date(`${year}-01-01`),
                    $lte: new Date(`${year}-12-31`),
                },
            },
        },
        {
            $group: {
                _id: {$month: "$startDates"},
                numMovieStarts: {$sum: 1},
                movies: {$push: "$name"},
            },
        },
        {
            $addFields: {month: "$_id"},
        },
        {
            $project: {
                _id: 0,
            },
        },
        {
            $sort: {numMovieStarts: -1},
        },
        {
            $limit: 12,
        },
    ]);

    res.status(200).json({
        status: "success",
        data: {
            plan,
        },
    });
});

// Pre booked movies

exports.getpbookedMovies = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.params.userid);
    console.log(user, "useruser");

    if (!user) {
        return next(new AppError("No user found with that ID", 404));
    }

    const {error} = preBookedMoviesValidations(req.params);
    if (error) {
        return next(new AppError(error.details[0].message, 400));
    }

    const transMovies = new APIFeatures(MovieTranscations.find(), {
        userId: req.params.userid,
    })
        .filter()
        .sort()
        .limitFields()
        .paginate();

    const transcations = await transMovies.query;

    let moviesIds = [];

    transcations.map((t) => {
        moviesIds.push(t.movieId);
    });

    const query = {_id: {$in: moviesIds}};
    const allmovie = await Movie.find(query);
    Movie.find;
    const test = allmovie.filter((movie) => movie.releaseDate > new Date());
    // const allmovie = await movies.query;
    // console.log(allmovie)

    //User.updateOne
    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Rent  Movies are here!",
        results: test,
    });
});

//
const multerStorageForSub = multer.memoryStorage();

const multerFilterForSub = (req, file, cb) => {
    if (!file.mimetype.startsWith("image")) {
        cb(null, true);
    } else {
        cb(new AppError("Not an csv! Please upload only csv.", 400), false);
    }
};

const uploadSub = multer({
    storage: multerStorageForSub,
    fileFilter: multerFilterForSub,
});

const filterObj = (obj, ...allowedFields) => {
    const newObj = {};
    Object.keys(obj).forEach((el) => {
        if (allowedFields.includes(el)) newObj[el] = obj[el];
    });
    return newObj;
};

exports.uploadSubtitle = uploadSub.single("photo");

//Routeuserhanddlers
//1
exports.uploadSubtitlesS3 = catchAsync(async (req, res, next) => {
    /*let myFile = req.file.originalname.split(".");
    const fileType = myFile[myFile.length - 1];

    const params = {
        Bucket: process.env.AWS_BUCKET_NAME,
        Key: `${uuid()}.${fileType}`,
        Body: req.file.buffer,
    };

    s3.upload(params, (error, data) => {
        if (error) {
            res.status(500).send(error);
        }

        res.status(200).send(data);
    });*/
});

// add subtitle to movie
exports.addSubtitleToMovie = catchAsync(async (req, res, next) => {
    const subtitles = await Movie.findById(req.params.id);
    if (!subtitles) {
        return next(new AppError("No movie found with that ID", 404));
    }
    const checkLan = subtitles.movieSubtitles.some(function (el) {
        return el.language == req.body.language;
    });
    if (checkLan == true) {
        return next(new AppError("Language already exists!", 404));
    } else {
        subtitles.movieSubtitles.push(req.body);
    }
    await subtitles.save();
    res.status(200).json({
        status: "success",
        message: "updated successfully",
        data: {
            subtitles,
        },
    });
});

// delete subtitle to movie
exports.deleteSubtitleToMovie = catchAsync(async (req, res, next) => {
    const subtitles = await Movie.findById(req.params.id);
    if (!subtitles) {
        return next(new AppError("No movie found with that ID", 404));
    }
    const deletedSub = subtitles.movieSubtitles.filter(
        (item) => item.language !== req.body.language
    );

    subtitles.movieSubtitles = deletedSub;
    await subtitles.save();
    res.status(200).json({
        status: "success",
        message: "updated successfully",
        data: {
            subtitles,
        },
    });
});

// update subtitle to movie
exports.updateSubtitleToMovie = catchAsync(async (req, res, next) => {
    const subtitles = await Movie.findById(req.params.id);
    if (!subtitles) {
        return next(new AppError("No movie found with that ID", 404));
    }
    const checkLan = subtitles.movieSubtitles.some(function (el) {
        return el.language != req.body.language;
    });
    if (checkLan == true) {
        return next(new AppError("Language does not exists!", 404));
    }

    const deletedSub = subtitles.movieSubtitles.filter(
        (item) => item.language !== req.body.language
    );
    deletedSub.push(req.body);
    subtitles.movieSubtitles = deletedSub;
    await subtitles.save();
    res.status(200).json({
        status: "success",
        message: "updated successfully",
        data: {
            subtitles,
        },
    });
});

exports.createUploadToken = catchAsync(async (req, res, next) => {
    /* const movie = await Movie.findById(req.params.id);
     if (!movie) {
       return next(new AppError("No movie found with that ID", 404));
     }*/

    const sasTokenObject = createAccountSAS('acw')
    res.status(200).json({
        status: "success",
        message: "token created successfully",
        data: {...sasTokenObject},
    });
})

exports.createEncoding = catchAsync(async (req, res, next) => {
    const urlObject = await startEncodingAndGetStreamingURLToStore(req.body.url + '?' + createAccountSAS().sasToken)
    res.status(200).json({
        status: "success",
        message: "url created successfully",
        data: {},
    });
});

exports.reRunJob = catchAsync(async (req, res, next) => {
    const movie = await Movie.findById(req.params.id);
    if (movie) {
        if(req.params.type === 'trailer' || req.params.type === 'movie'){
            res.status(200).json({
                status: "success",
                message: "Job request successful",
                data: {},
            });
            try{
                await checkForJobStatusAndResubmit(movie, req.params.type === 'movie');
            }catch (failErr){
                console.error('movieController:reRunJob: ',failErr);
            }

        }else{
            res.status(400).json({
                status: "Invalid type",
                message: "Job request failed",
                data: {},
            });
        }

    } else {
        res.status(404).json({
            status: "not found",
            message: "movie not found",
            data: {},
        });
    }
})

exports.updateJobStatus = catchAsync(async (req,res,next)=>{
    const movie = await Movie.findById(req.params.id);
    if (movie) {
        // check status for movie
        await checkForJobStatusAndResubmit(movie, true,false);

        const trailerMovieObj = await Movie.findById(req.params.id);

        await checkForJobStatusAndResubmit(trailerMovieObj, false,false);
        res.status(200).json({
            status: "success",
            message: "Job status refreshed",
            data: {},
        });
    } else {
        res.status(404).json({
            status: "not found",
            message: "movie not found",
            data: {},
        });
    }
})
