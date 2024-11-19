const Reward = require("./../models/rewardModel");
const catchAsync = require("../utils/catchAsync");

const {
  addCouponValidation,
  updateCouponValidation,
} = require("./../utils/validations/couponValidation");
const AppError = require("../utils/appError");

//Routerewardhanddlers
//1
exports.getAllRewards = catchAsync(async (req, res) => {
  const rewards = await Reward.find();

  res.status(200).json({
    status: "success",
    message: "Rewards fetched successfully",
    results: rewards.length,
    data: {
      reward: rewards,
    },
  });
});

exports.getReward = catchAsync(async (req, res, next) => {
  const reward = await Reward.findById(req.params.id);
  // Reward.findOne({ _id: req.params.id })

  if (!reward) {
    return next(new AppError("No reward found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "Reward fetched successfully",
    data: {
      reward,
    },
  });
});

exports.createReward = catchAsync(async (req, res, next) => {
  //Validate Data
  const body = req.body;

  // const { error } = addCouponValidation(body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const newReward = await Reward.create(req.body);

  res.status(201).json({
    status: "success",
    message: "Rewards created successfully",
    data: {
      reward: newReward,
    },
  });
});

exports.updateReward = catchAsync(async (req, res, next) => {
  //Validate Data
  // const { error } = updateCouponValidation(req.body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const reward = await Reward.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  });

  if (!reward) {
    return next(new AppError("No reward found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "Reward updated successfully",
    data: {
      reward,
    },
  });
});

exports.deleteReward = catchAsync(async (req, res, next) => {
  const reward = await Reward.findByIdAndDelete(req.params.id);

  if (!reward) {
    return next(new AppError("No reward found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "Reward deleted successfully",
    data: null,
  });
});
