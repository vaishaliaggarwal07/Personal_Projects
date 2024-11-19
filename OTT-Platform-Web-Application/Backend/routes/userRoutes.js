const express = require("express");
const userController = require("./../controllers/userController");
const authController = require("./../controllers/authController");

const router = express.Router();

// router.post("/signup", authController.signup);
router.post("/signup/firebase", authController.signUpWithFirebase);
router.post("/login", authController.login);
router.get("/logout", authController.logout);
router.get('/token/public',authController.createPublicToken)
// router.post("/loginwithfirebase", authController.socialLogin);

router.post("/forgotPassword", authController.forgotPassword);
router.patch("/resetPassword/:id", authController.resetPassword);
router.patch("/expireCoupon/:id", userController.expireCoupon);
router.patch("/expireReward/:id", userController.expireReward);
router.get("/getUserByRefCode/:id", userController.getUserByRefCode);
router.patch("/addReward/:id", userController.addReward);

router.patch("/verifyOTP", authController.verifyOTP);
router.post("/resendOTP", authController.resendOTP);
router.get("/getUserByEmail/:email", userController.getUserByEmail);

router
  .route("/")
  .get(
    // passport.authenticate("jwt", { session: false }),
    userController.getAllUsers
  )
  .post(
    userController.createUser
  );

router.route("/recent-users").get(userController.getRecentlyAdded);

router
  .route("/:id")
  .get(userController.getUser)
  .patch(
    userController.updateUser
  )
  .delete(userController.deleteUser);

router.route("/:id/photo").patch(userController.updatePhoto)

module.exports = router;
