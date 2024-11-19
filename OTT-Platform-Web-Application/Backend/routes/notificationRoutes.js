const express = require("express");
const notificationController = require("../controllers/notificationController");
// const passport = require("passport");

const router = express.Router();

router
  .route("/")
  .get(
    // passport.authenticate("jwt", { session: false }),
    notificationController.getAllNotifications
  )
  .post(
    // passport.authenticate("jwt", { session: false }),
    notificationController.createNotification
  );

module.exports = router;
