const {upsertValidation} = require("../utils/validations/currentUserMovieValidation");
const CurrentUserMovie = require("./../models/currentUserMovie");
const catchAsync = require("./../utils/catchAsync");
const AppError = require("../utils/appError");


exports.upsertUserMovieTime = catchAsync(async (req, res, next) => {
    const body = req.body;
    //Validate Data
    const {error} = upsertValidation(body);
    if (error) return next(new AppError(error.details[0].message, 400));

    const query = {movieId: req.body.movieId, userId: req.user._id};
    const dbBody = {
        ...query,
        currentTime:req.body.currentTime
    }

    const result = await CurrentUserMovie.findOneAndUpdate(query, dbBody, {upsert: true});

    // SEND RESPONSE
    res.status(200).json({
        status: "success",
        message: "Current time save successfully",
        data: result,
    });
});

exports.getCurrentUserMovieTime = catchAsync(async (req, res, next) => {

    const movieId = req.params.id
    if(movieId && movieId !=='undefined' && movieId !== ''){
        const query = {movieId, userId: req.user._id};

        const result = await CurrentUserMovie.findOne(query);
        const resJson = {
            status: "success",
            message: "Current time get successfully",
            data: {
                current_time:0,
            },
        }
        if(result){
            resJson.data.current_time = result.currentTime
            res.status(200).json(resJson);
        }else{
            res.status(200).json(resJson);
        }


    }else{
        return next(new AppError('no movie id', 400))
    }

});
