const APIFeatures = require("./../utils/apiFeatures");
const catchAsync = require("./../utils/catchAsync");
const AppError = require("./../utils/appError");
const { verifyTranscations, createOrder } = require("../service/movieService");
const MovieTranscations = require("../models/movieTrasncations");
const {
  createOrderValidation,
  verifyOrderBody,
} = require("./../utils/validations/movieValidation");
const Razorpay = require("razorpay");
const Movie = require("./../models/movieModel");

const shortid = require("shortid");
const ObjectId = require('mongoose').Types.ObjectId;
const {appendSASToBanner} = require('../service/azureService');

var instance = new Razorpay({
  key_id: "rzp_test_qWmQrhu8qFgJ42",
  key_secret: "UdD6xNgAUCTJdlsqoObzLjV2",
});

exports.verifyOrder = catchAsync(async (req, res, next) => {
  const { error } = verifyOrderBody(req.body);
  if (error) {
    return next(new AppError(error.details[0].message, 400));
  }

  const { order_id, payment_id, movie_booking_type,razorpay_signature } = req.body;

  if (!razorpay_signature)
    return next(new AppError("x-razorpay-signature hedaer not found!", 400));

  let generated_signature = await verifyTranscations(
    order_id,
    payment_id,
    razorpay_signature
  );

  if (generated_signature === generated_signature) {
    // MovieTranscations.updateOne
    const transcation = await MovieTranscations.find({ orderId: order_id });
    if (!transcation || transcation.length == 0) {
      return next(new AppError("No transcation found with that order id", 404));
    }
    const updates = Object.keys(req.body);
    updates.forEach((update) => {
      if (req.body[update].includes(",")) {
        transcation[0][update] = req.body[update].split(",");
      } else {
        transcation[0][update] = req.body[update];
      }
    });
    await MovieTranscations.updateOne(transcation[0]);

    const data = await MovieTranscations.find({ orderId: order_id });

    const test = data[data.length - 1];
    test.status = "Paid";
    await test.save();

    res.status(200).json({
      status: "success",
      message:
        "Payment has been verified and movie has been " +
        movie_booking_type +
        "ED",
      results: transcation,
    });
  } else
    res.status(500).json({
      status: "error",
      message: "Payment verification failed",
      results: null,
    });
});

exports.createOrder = catchAsync(async (req, res, next) => {
  const { error } = createOrderValidation(req.body);
  if (error) return next(new AppError(error.details[0].message, 400));

  const { amount, currency, receipt, notes, userId, movieId, streamed } =
    req.body;

  const payment_id = null;

  // disabling razor pay
  /*let order = await createOrder(amount, currency, receipt, notes);
  const order_id = order.id;*/
  const order_id ='disabling_the_payment'

  MovieTranscations.create({
    userId,
    movieId,
    amount,
    currency,
    receipt,
    notes,
    payment_id,
    order_id,
    streamed,
  });
  // SEND RESPONSE
  res.status(200).json({
    status: "success",
    message: "Order Created Succcessfully!",
    results: { order },
  });
});

///
exports.getAllOrder = catchAsync(async (req, res) => {
  const orders = await MovieTranscations.find();
  console.log(req, "reqreq");

  res.status(200).json({
    status: "success",
    message: "Order fetched successfully!!",
    results: orders.length,
    data: {
      order: orders,
    },
  });
});

exports.getAllRentedMovies = catchAsync(async (req, res) => {
  const orderList = await MovieTranscations.find({userId:ObjectId(req.params.id)});

  res.status(200).json({
    status: "success",
    message: "Order fetched successfully!!",
    results: orderList.length,
    data: {
      order: orderList,
    },
  });
});

exports.updateOrder = catchAsync(async (req, res, next) => {
  const orders = await MovieTranscations.findByIdAndUpdate(
    req.params.id,
    req.body,
    {
      new: true,
      runValidators: true,
    }
  );

  console.log(orders, "orders");

  if (!orders) {
    return next(new AppError("No orders found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "Stream started!",
    data: {
      orders,
    },
  });
});

exports.getAllStreanedMovies = catchAsync(async (req, res) => {
  const orders = await MovieTranscations.find();
  const test = orders.filter((i) =>
    i.userId ? i.userId._id : "" == req.params.id
  );
  const streamData = test.filter((i) => i.streamed === true);
  res.status(200).json({
    status: "success",
    message: "Order fetched successfully!!",
    results: streamData.length,
    data: {
      order: streamData,
    },
  });
});
