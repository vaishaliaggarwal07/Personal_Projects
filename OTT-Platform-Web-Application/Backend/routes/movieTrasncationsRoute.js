const express = require("express");
const movieTrasncations = require("../controllers/movieTrasncationsController");
const router = express.Router();

router.route("/createOrder").post(movieTrasncations.createOrder);
router.route("/verifyOrderAndBookMovie").post(movieTrasncations.verifyOrder);
router.route("/getAllOrder").get(movieTrasncations.getAllOrder);
router
  .route("/getAllRentedMovies/:id")
  .get(movieTrasncations.getAllRentedMovies);
router
  .route("/getAllStreanedMovies/:id")
  .get(movieTrasncations.getAllStreanedMovies);
router.route("/:id").patch(movieTrasncations.updateOrder);

module.exports = router;
