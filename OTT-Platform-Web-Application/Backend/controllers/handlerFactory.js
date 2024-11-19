const catchAsync = require("./../utils/catchAsync");
const AppError = require("./../utils/appError");
const APIFeatures = require("./../utils/apiFeatures");
const User = require("../models/userModel");
const Movie = require("../models/movieModel");

exports.deleteOne = (Model) =>
  catchAsync(async (req, res, next) => {
    const review = await Model.findById(req.params.id);
    const doc = await Model.findByIdAndDelete(req.params.id);

    if (!doc) {
      return next(new AppError("No document found with that ID", 404));
    }
    console.log(review);

    const dv2 = await Model.find({ movieId: review.movieId });
    console.log(dv2);
    await Movie.findByIdAndUpdate(review.movieId, {
      totalReviewsCount: dv2.length,
    });

    res.status(200).json({
      status: "success",
      message: "deleted Successfully",
      data: null,
    });
  });

exports.updateOne = (Model) =>
  catchAsync(async (req, res, next) => {
    // const doc = await Model.findByIdAndUpdate(req.params.id, req.body, {
    //   new: true,
    //   runValidators: true,
    // });
    const doc = await Model.findById(req.params.id);
    if (!doc) {
      return next(new AppError("No document found with that ID", 404));
    }

    const updates = Object.keys(req.body);
    updates.forEach((update) => (doc[update] = req.body[update]));
    await doc.save();

    res.status(200).json({
      status: "success",
      message: "updated successfully",
      data: {
        data: doc,
      },
    });
  });

exports.updateStatus = (Model) =>
  catchAsync(async (req, res, next) => {
    // const doc = await Model.findByIdAndUpdate(req.params.id, req.body, {
    //   new: true,
    //   runValidators: true,
    // });

    const doc = await Model.findById(req.query.reviewId);
    if (!doc) {
      return next(new AppError("No document found with that ID", 404));
    }

    const user = await User.findById(req.body.user);
    console.log(user);
    if (!user) {
      return next(new AppError("User Not Found!", 404));
    }

    if (user.userType != "admin") {
      return next(
        new AppError("User dont have permission to update status", 404)
      );
    }

    delete req.body.user;
    console.log(req.body);
    const updates = Object.keys(req.body);
    updates.forEach((update) => (doc[update] = req.body[update]));
    await doc.save();

    res.status(200).json({
      status: "success",
      message: "updated successfully",
      data: {
        data: doc,
      },
    });
  });

exports.createOne = (Model) =>
  catchAsync(async (req, res, next) => {
    const d = await Model.find({
      $and: [{ movieId: req.body.movieId }, { user: req.body.user }],
    });
    if (d.length > 0) {
      return next(
        new AppError("Same user cannot review again to same movie", 401)
      );
    }
    req.body.isApproved = false;
    const doc = await Model.create(req.body);

    const dv2 = await Model.find({ movieId: req.body.movieId });

    if (dv2.length != 0) {
      await Movie.findById(req.body.movieId, {
        totalReviewsCount: dv2.length,
      });
    }

    res.status(201).json({
      status: "success",
      message: "created successfully",
      data: {
        data: doc,
      },
    });
  });

exports.getOne = (Model, popOptions) =>
  catchAsync(async (req, res, next) => {
    let query = Model.findById(req.params.id);
    if (popOptions) query = query.populate(popOptions);
    const doc = await query;

    if (!doc) {
      return next(new AppError("No document found with that ID", 404));
    }

    res.status(200).json({
      status: "success",
      message: "fetch successfully",
      data: {
        data: doc,
      },
    });
  });

exports.getAll = (Model) =>
  catchAsync(async (req, res, next) => {
    // To allow for nested GET reviews on movie (hack)
    let filter = {};
    if (req.params.movieId) filter = { movieId: req.params.movieId };

    const features = new APIFeatures(Model.find(filter), req.query)
      .filter()
      .sort()
      .limitFields()
      .paginate();
    // const doc = await features.query.explain();
    const doc = await features.query;

    // SEND RESPONSE
    res.status(200).json({
      status: "success",
      message: "fetch successfully",
      results: doc.length,
      data: {
        data: doc,
      },
    });
  });
