const User = require("../models/userModel");
const APIFeatures = require("../utils/apiFeatures");
const AppError = require("../utils/appError");
const sendEmail = require("../utils/email");
const {
  addUserMovieValidation,
  updateUserMovieValidation,
} = require("../utils/validations/userMovieValidation");
const UserMovie = require("./../models/userMovies");
const catchAsync = require("./../utils/catchAsync");

// Get All User Movies
exports.getAllUserMovies = catchAsync(async (req, res, next) => {
  const userMovies = new APIFeatures(UserMovie.find(), {})
    .filter()
    .sort()
    .limitFields()
    .paginate();

  const movies = await userMovies.query;

  // SEND RESPONSE
  res.status(200).json({
    status: "success",
    results: movies.length,
    message: "Movies Fetch successfully",
    data: {
      movies,
    },
  });
});

// Fetch User movies by User Id
exports.getUserMovies = catchAsync(async (req, res, next) => {
  const userMovies = new APIFeatures(
    UserMovie.find({ userId: req.params.userid }),
    {}
  )
    .filter()
    .sort()
    .limitFields()
    .paginate();

  const movies = await userMovies.query;

  // SEND RESPONSE
  res.status(200).json({
    status: "success",
    message: "Movie fetched Successfully",
    results: movies.length,
    data: {
      movies,
    },
  });
});

exports.createUserMovie = catchAsync(async (req, res, next) => {
  const { error } = addUserMovieValidation(req.body);
  if (error) return next(new AppError("No movie found with that ID", 404));
  // req.body.userId = req.params.userId;
  const newMovie = await UserMovie.create(req.body);
console.log(newMovie);
  res.status(201).json({
    message: "Movie created Successfully",
    status: "success",
    data: {
      movie: newMovie,
    },
  });
});

exports.updateUserMovie = catchAsync(async (req, res, next) => {
  const { error } = updateUserMovieValidation(req.body);
  if (error) return next(new AppError(error.details[0].message, 400));
  const movie = await UserMovie.findById(req.params.id);

  if (!movie) {
    return next(new AppError("No movie found with that ID", 404));
  }
  delete req.body.userId;
  const updates = Object.keys(req.body);
  updates.forEach((update) => (movie[update] = req.body[update]));
  await movie.save();

  res.status(201).json({
    status: "success",
    message: "Movie updated Successfully",
    data: {
      movie: movie,
    },
  });
});

exports.deleteUserMovie = catchAsync(async (req, res, next) => {
  const movie = await UserMovie.findByIdAndDelete(req.params.id);

  if (!movie) {
    return next(new AppError("No movie found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "Movie deleted successfully",
    data: null,
  });
});
// Middleware to add userId from parmas to body
// exports.updateBodyWithUserid = catchAsync(async (req, res, next) => {
//   // req.body["userId"] = "";
//   if (req.params.userId) {
//     console.log(req.body);

//     req.body.userId = req.params.userId;
//     console.log(req.body.userId);
//   } else {
//     next(new AppError("User id not found", 404));
//   }
//   next();
// });
