const express = require("express");
const joinUsController = require("./../controllers/joinUsController");
const authController = require("./../controllers/authController");

const router = express.Router();

router
  .route("/")
  .get(
    // passport.authenticate("jwt", { session: false }),
    joinUsController.getAllJoinUs
  )
  .post(
    joinUsController.createJoinUs
  );

router
  .route("/:id")
  .get(joinUsController.getJoinUs)
  .patch(
    joinUsController.updateJoinUs
  )
  .delete(joinUsController.deleteJoinUs);

module.exports = router;
