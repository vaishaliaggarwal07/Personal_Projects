const express = require("express");
const currentUserMovie = require("../controllers/currentUserMovieController");
const authController = require("../controllers/authController");

const router = express.Router();

router
    .route("")
    .post(
        authController.protect,
        currentUserMovie.upsertUserMovieTime
    );

router
    .route("/:id")
    .get(
        authController.protect,
        currentUserMovie.getCurrentUserMovieTime
    );
module.exports = router;
