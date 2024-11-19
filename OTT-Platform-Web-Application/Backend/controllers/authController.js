const crypto = require("crypto");
const { promisify } = require("util");
const User = require("./../models/userModel");
const catchAsync = require("./../utils/catchAsync");
const jwt = require("jsonwebtoken");
const AppError = require("./../utils/appError");
const sendEmail = require("./../utils/email");
const {
  registerValidation,
  registerFirebaseValidation,
  loginValidation,
} = require("./../utils/validations/userValidation");
const firebaseService = require('../service/firebaseService');
// const { loginViaFirebaseToken } = require("../service/userService");

const signToken = (id,userType) => {
  return jwt.sign({id,ut:userType}, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

exports.signup = catchAsync(async (req, res, next) => {
  const body = req.body;
  //Validate Data
  const { error } = registerValidation(body);
  if (error) return next(new AppError(error.details[0].message, 400));

  const newUser = await User.create({
    userName: req.body.userName,
    email: req.body.email,
    password: req.body.password,
    passwordConfirm: req.body.passwordConfirm,
    userType: req.body.userType,
    firebaseId: null,
  });

  const token = signToken(newUser._id,newUser.userType);

  res.status(201).json({
    status: "success",
    message: `${req.body.userType} account created successfully`,
    token,
    data: {
      user: newUser,
    },
  });
});

exports.login = catchAsync(async (req, res, next) => {
  const body = req.body;
  //Validate Data
  const { error } = loginValidation(body);
  if (error) return next(new AppError(error.details[0].message, 400));
  const { email, password, userType } = req.body;

  //If email and pass exist
  if (!email || !password) {
    return next(new AppError("Please provide us email and password!", 400));
  }
  if (!userType) {
    return next(new AppError("Please enter valid userType!", 400));
  }

  // 2) Check if user exists && password is correct
  const user = await User.findOne({ email }).select("+password");

  if (!user || !(await user.correctPassword(password, user.password))) {
    return next(new AppError("Incorrect email or password", 401));
  }
  if (user.userType !== userType) {
    return next(new AppError("Incorrect userType", 401));
  }

  // if everything is ok then send token to client
  const token = signToken(user._id,user.userType);

  res.status(200).json({
    id: user._id,
    status: "success",
    token,
    message: `${req.body.userType} login successfully`,
  });
});

exports.logout = (req, res) => {
  res.cookie("jwt", "loggedout", {
    expires: new Date(Date.now() + 10 * 1000),
    httpOnly: true,
  });
  res.status(200).json({ status: "success" });
};

/*exports.socialLogin = catchAsync(async (req, res) => {
  console.log(req.body);
  let user = await loginViaFirebaseToken(req.body);
  console.log(user);
  const token = signToken(user._id);

  res.status(200).json({
    id: user._id,
    status: "success",
    token,
    message: `${req.body.userType} login successfully`,
  });
});*/

exports.protect = catchAsync(async (req, res, next) => {
  // 1) Getting token and checking if its there
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    token = req.headers.authorization.split(" ")[1];
  }

  if (!token) {
    return next(
      new AppError("You are not logged in! Please log in to get access.", 401)
    );
  }

  // 2) verification token
  const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);

  //3) check if user still exists
  const currentUser = await User.findById(decoded.id);
  if (!currentUser) {
    return next(
      new AppError("The user belonging to this user is no longer exist.", 401)
    );
  }

  //4) if user changed password after token isuued
  if (currentUser.changedPasswordAfter(decoded.iat)) {
    return next(
      new AppError("User recently changed password! Please login again", 401)
    );
  }

  //Grant access to route
  req.user = currentUser;
  next();
});

// Only for rendered pages, no errors!
exports.isLoggedIn = async (req, res, next) => {
  if (req.cookies.jwt) {
    try {
      // 1) verify token
      const decoded = await promisify(jwt.verify)(
        req.cookies.jwt,
        process.env.JWT_SECRET
      );

      // 2) Check if user still exists
      const currentUser = await User.findById(decoded.id);
      if (!currentUser) {
        return next();
      }

      // 3) Check if user changed password after the token was issued
      if (currentUser.changedPasswordAfter(decoded.iat)) {
        return next();
      }

      // THERE IS A LOGGED IN USER
      res.locals.user = currentUser;
      return next();
    } catch (err) {
      return next();
    }
  }
  next();
};

exports.forgotPassword = catchAsync(async (req, res, next) => {
  // 1) Get user based on POSTed email
  const user = await User.findOne({ email: req.body.email });

  if (!user) {
    return next(new AppError("There is no user with email address.", 404));
  }

  // GEN OTP
  const otp = Math.floor(1000 + Math.random() * 9000);
  const expiryotp = new Date(Date.now() + 20 * 3000);
  user.otp = otp;
  user.expiryotp = expiryotp;

  // 2) Generate the random reset token
  const resetToken = user.createPasswordResetToken();
  await user.save({ validateBeforeSave: false });
  // 3) Send it to user's email
  const resetURL = `${resetToken}`;

  const message = `Forgot your password? Your OTP is: ${otp}.\nIf you didn't forget your password, please ignore this email!`;

  try {
    await sendEmail({
      email: user.email,
      subject: "Your password reset otp (valid for 10 min)",
      message,
    });

    res.status(200).json({
      status: "success",
      message: "OTP sent to email!",
    });
  } catch (err) {
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;
    await user.save({ validateBeforeSave: false });

    return next(
      new AppError("There was an error sending the email. Try again later!"),
      500
    );
  }
});

exports.verifyOTP = catchAsync(async (req, res, next) => {
  const crunenttime = Date.now();

  const matchotp = await User.findOne({ email: req.body.email });
  if (matchotp.expiryotp < crunenttime) {
    return res.status(401).json({
      status: "false",
      message: "OTP Expired!",
    });
  }
  if (matchotp.otp === req.body.otp) {
    return res.status(200).json({
      id: matchotp._id,
      status: "success",
      message: "OTP verified successfully!",
    });
  } else {
    return res.status(400).json({
      status: "error",
      message: "Please try again",
    });
  }
  // 1) Get user based on the token
  // const hashedToken = crypto
  //   .createHash("sha256")
  //   .update(req.params.token)
  //   .digest("hex");
  // const user = await User.findOne({
  //   passwordResetToken: hashedToken,
  //   passwordResetExpires: { $gt: Date.now() },
  // });
  // // 2) If token has not expired, and there is user, set the new password
  // if (!user) {
  //   return next(new AppError("Token is invalid or has expired", 400));
  // }
  // user.password = req.body.password;
  // user.passwordConfirm = req.body.passwordConfirm;
  // user.passwordResetToken = undefined;
  // user.passwordResetExpires = undefined;
  // await user.save();
  // // 3) Update changedPasswordAt property for the user
  // // 4) Log the user in, send JWT
  // createSendToken(user, 200, res);
});

exports.resetPassword = catchAsync(async (req, res, next) => {
  const user = await User.findById(req.params.id);

  if (!user) {
    return next(new AppError("User not found!", 400));
  }
  user.password = req.body.password;
  await user.save();

  return res.status(200).json({
    status: "success",
    message: "Password changed successfully!",
    user,
  });
});

exports.resendOTP = catchAsync(async (req, res, next) => {
  // 1) Get user based on POSTed email
  const user = await User.findOne({ email: req.body.email });

  if (!user) {
    return next(new AppError("There is no user with email address.", 404));
  }

  // GEN OTP
  const otp = Math.floor(1000 + Math.random() * 9000);
  const expiryotp = new Date(Date.now() + 20 * 3000);
  user.otp = otp;
  user.expiryotp = expiryotp;

  // 2) Generate the random reset token
  const resetToken = user.createPasswordResetToken();
  await user.save({ validateBeforeSave: false });

  // 3) Send it to user's email
  const resetURL = `${resetToken}`;

  const message = `Forgot your password? Your OTP is: ${otp}.\nIf you didn't forget your password, please ignore this email!`;

  try {
    await sendEmail({
      email: user.email,
      subject: "Your password reset otp (valid for 10 min)",
      message,
    });

    res.status(200).json({
      status: "success",
      message: "OTP sent to email!",
    });
  } catch (err) {
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;
    await user.save({ validateBeforeSave: false });

    return next(
      new AppError("There was an error sending the email. Try again later!"),
      500
    );
  }
});

exports.signUpWithFirebase = catchAsync(async (req, res, next) => {
  const body = req.body;
  //Validate Data
  const { error } = registerFirebaseValidation(body);
  if (error) return next(new AppError(error.details[0].message, 400));

  const decodedFirebaseToken = await firebaseService.validateAuthToken(req.body.firebaseToken);
  let  existingUser,newUser;
  if(req.body.firebaseUID === decodedFirebaseToken.uid){
    existingUser = await User.findOne({ firebaseId: req.body.firebaseUID});
    if(existingUser){
      newUser=existingUser;
    }else{
      newUser = await User.create({
        mobile:req.body.mobile,
        userType: 'user',
        firebaseId: decodedFirebaseToken.uid,
      });
    }
  }else{
    throw new Error('Invalid UID and token')
  }

  const token = signToken(newUser._id,newUser.userType);

  res.status(201).json({
    status: "success",
    message: `${req.body.userType} ${existingUser?' Logged in successfully':' created successfully'}`,
    token,
    id: newUser._id,
    data: {
      user: newUser,
    },
  });
});

exports.createPublicToken = catchAsync(async (req,res,next)=>{
  res.cookie('public', signToken('0','public'), { expires: new Date(Date.now() + 900000), httpOnly: true, /*secure: true*/ });
  res.status(200).json({status:'success'})
})
