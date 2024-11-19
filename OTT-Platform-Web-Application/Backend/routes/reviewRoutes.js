const express = require("express");
const reviewController = require("./../controllers/reviewController");
const authController = require("./../controllers/authController");

const router = express.Router({ mergeParams: true });

// router.use(authController.protect);

router
  .route("/")
  .get(reviewController.getAllReviews)
  .post(authController.protect, reviewController.createReview);

router
  .route("/:id")
  .get(reviewController.getReview)
  .patch(authController.protect, reviewController.updateReview)
  .delete(authController.protect, reviewController.deleteReview);

router
  .route("/updatestatus")
  .post(authController.protect, reviewController.updateStatus);

module.exports = router;
