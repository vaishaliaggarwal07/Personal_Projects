const express = require("express");
const purchaseController = require("../controllers/purchaseController");
// const passport = require("passport");

const router = express.Router();

router
  .route("/")
  .get(
    // passport.authenticate("jwt", { session: false }),
    purchaseController.createPurchase
  )
  .post(
    // passport.authenticate("jwt", { session: false }),
    purchaseController.getAllPurchase
  );

module.exports = router;
