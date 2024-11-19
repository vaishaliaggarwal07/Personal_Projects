const express = require("express");
const userMovieController = require("../controllers/userMovieController");
const authController = require("../controllers/authController");

const router = express.Router();

router
  .route("/")
  .get(
   authController.protect,
    userMovieController.getAllUserMovies
    );

router
  .route("/:userid")
  .get(
   authController.protect,
    userMovieController.getUserMovies)
  .post(
   authController.protect,
    // userMovieController.updateBodyWithUserid,
    userMovieController.createUserMovie
  );

router
  .route("/:id")
  .patch(
   authController.protect,
    userMovieController.updateUserMovie
  )
  .delete(
   authController.protect,
    userMovieController.deleteUserMovie
  );

module.exports = router;
