const express = require("express");
const castController = require("./../controllers/castController");
const authController = require("./../controllers/authController");

const router = express.Router({ mergeParams: true });

// router.use(authController.protect);

router
  .route("/")
  .get(castController.getAllCasts)
  .post(
    authController.protect,
    castController.uploadCastPhoto,
    castController.resizeCastPhoto,
    castController.createCast
  );

router
  .route("/:id")
  .get(castController.getCast)
  .patch(
    authController.protect,
    castController.uploadCastPhoto,
    castController.resizeCastPhoto,
    castController.updateCast
  )
  .delete(authController.protect, castController.deleteCast);

module.exports = router;
