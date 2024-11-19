const catchAsync = require("../utils/catchAsync");
const Notification = require("../models/notificationModel");

// notification
exports.createNotification = catchAsync(async (req, res, next) => {
  const notification = await Notification.create(req.body);

  res.status(201).json({
    status: "success",
    message: "created successfully!",
    data: {
      notification: notification,
    },
  });
});

exports.getAllNotifications = catchAsync(async (req, res) => {
  const notification = await Notification.find();

  res.status(200).json({
    status: "success",
    message: "Notification fetched successfully!",
    results: notification.length,
    data: {
      notification: notification,
    },
  });
});
