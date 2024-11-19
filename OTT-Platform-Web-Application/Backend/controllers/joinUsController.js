const JoinUs = require("./../models/joinUsModel");
const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");

exports.getAllJoinUs = catchAsync(async (req, res) => {
  const joinUsData = await JoinUs.find();

  res.status(200).json({
    status: "success",
    message: "JoinUs data fetched successfully",
    results: joinUsData.length,
    data: {
      joinUs: joinUsData,
    },
  });
});

exports.createJoinUs = catchAsync(async (req, res, next) => {
  const newJoinUsData = await JoinUs.create(req.body);

  res.status(201).json({
    status: "success",
    message: "JoinUs data created successfully",
    data: newJoinUsData,
  });
});

exports.getJoinUs = catchAsync(async (req, res, next) => {
  const joinUsData = await JoinUs.findById(req.params.id);

  if (!joinUsData) {
    return next(new AppError("No JoinUs data found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "JoinUs data fetched successfully",
    data: {
      joinUs: joinUsData,
    },
  });
});

exports.updateJoinUs = catchAsync(async (req, res, next) => {
  const joinUsId = req.params.id;

  try {
    const updatedJoinUsData = await JoinUs.findByIdAndUpdate(
      joinUsId,
      req.body,
      { new: true, runValidators: true }
    );

    if (!updatedJoinUsData) {
      return next(new AppError("No JoinUs data found with that ID", 404));
    }

    res.status(200).json({
      status: "success",
      message: "JoinUs data updated successfully",
      data: {
        joinUs: updatedJoinUsData,
      },
    });
  } catch (err) {
    next(err);
  }
});

exports.deleteJoinUs = catchAsync(async (req, res, next) => {
  const joinUsId = req.params.id;

  const joinUsData = await JoinUs.findByIdAndDelete(joinUsId);

  if (!joinUsData) {
    return next(new AppError("No JoinUs data found with that ID", 404));
  }

  res.status(204).json({
    status: "success",
    message: "JoinUs data deleted successfully",
    data: null,
  });
});
