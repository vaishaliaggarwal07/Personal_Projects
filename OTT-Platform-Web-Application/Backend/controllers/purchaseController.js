const catchAsync = require("../utils/catchAsync");
const Purchase = require("../models/purchaseModel");

// notification
exports.createPurchase = catchAsync(async (req, res, next) => {
  const purchase = await Purchase.create(req.body);

  res.status(201).json({
    status: "success",
    message: "created successfully!",
    data: {
      purchase: purchase,
    },
  });
});

exports.getAllPurchase = catchAsync(async (req, res) => {
  const purchase = await Purchase.find();

  res.status(200).json({
    status: "success",
    message: "PurchaseMovie fetched successfully!",
    results: purchase.length,
    data: {
      purchase: purchase,
    },
  });
});
