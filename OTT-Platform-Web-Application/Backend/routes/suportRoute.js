const express = require("express");
const suportController = require("../controllers/suportController");
// const passport = require("passport");

const router = express.Router();

router
  .route("/")
  .post(
    // passport.authenticate("jwt", { session: false }),
    suportController.createSuport
  )
  .get(
    // passport.authenticate("jwt", { session: false }),
    suportController.getAllSuport
  );
router
  .route("/:id")
  .get(suportController.getSuport)
module.exports = router;
