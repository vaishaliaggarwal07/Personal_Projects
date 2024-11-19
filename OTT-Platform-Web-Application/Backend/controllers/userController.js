const User = require("./../models/userModel");
const catchAsync = require("../utils/catchAsync");
const AppError = require("../utils/appError");
const APIFeatures = require("./../utils/apiFeatures");
const jwt = require("jsonwebtoken");

const multer = require("multer");
const sharp = require("sharp");
const {
  updateUserValidation,
  createUserValidation,
} = require("./../utils/validations/userValidation");
const { default: mongoose } = require("mongoose");

const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

const createSendToken = (user, statusCode, res) => {
  const token = signToken(user._id);
  const cookieOptions = {
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRES_IN * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
  };
  if (process.env.NODE_ENV === "production") cookieOptions.secure = true;

  res.cookie("jwt", token, cookieOptions);
};
//Upload image
const multerStorage = multer.memoryStorage();

const multerFilter = (req, file, cb) => {
  if (file.mimetype.startsWith("image")) {
    cb(null, true);
  } else {
    cb(new AppError("Not an image! Please upload only images.", 400), false);
  }
};

const upload = multer({
  storage: multerStorage,
  fileFilter: multerFilter,
});

const filterObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach((el) => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};

exports.uploadUserPhoto = upload.single("photo");

//Resizing Image
exports.resizeUserPhoto = catchAsync(async (req, res, next) => {
  if (!req.file) return next();
  const fileName = `user-profile-${Date.now()}.jpeg`;
  const filePath = "public/img/users";
  await sharp(req.file.buffer)
    .resize(500, 500)
    .toFormat("jpeg")
    .jpeg({ quality: 90 })
    .toFile(`${filePath}/${fileName}`);

  req.body.photo = `http://localhost:${process.env.PORT}/img/users/${fileName}`;
  next();
});

//Routeuserhanddlers
//1
exports.getAllUsers = catchAsync(async (req, res) => {
  const users = await User.find();

  res.status(200).json({
    status: "success",
    message: "Users fetched successfully",
    results: users.length,
    data: {
      user: users,
    },
  });
});
exports.getUserByEmail = catchAsync(async (req, res, next) => {
  const  Useremail  = req.params.email; 

  const user = await User.findOne({ Useremail });

  if (!user) {
    return next(new AppError('No user found with that email', 404));
  }

  res.status(200).json({
    status: 'success',
    message: 'User fetched successfully by email',
    data: {
      user,
    },
  });
});

exports.getUser = catchAsync(async (req, res, next) => {
  const user = await User.findById(req.params.id);

  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: `${user.userType} fetched successfully`,
    data: {
      user,
    },
  });
});

exports.createUser = catchAsync(async (req, res, next) => {
  //Validate Data
  // const { error } = createUserValidation(req.body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const newUser = await User.create(req.body);

  const token = signToken(newUser._id);

  res.status(201).json({
    status: "success",
    message: `${req.body.userType} created successfully`,
    token,
    data: newUser,
  });
});

exports.getRecentlyAdded = catchAsync(async (req, res, next) => {
  let query = { users: { $exists: true, $ne: "", $ne: null }, limit: 10 };
  const recentUser = new APIFeatures(User.find(), query)
    .filter()
    .sort()
    .limitFields()
    .paginate();

  const users = await recentUser.query;

  // SEND RESPONSE
  res.status(200).json({
    status: "success",
    message: "Users fetched successfully",
    results: users.length,
    data: {
      users,
    },
  });
});

exports.updateUser = catchAsync(async (req, res, next) => {
  const userId = req.params.id;
  // const userId = "123";
  // if (!mongoose.isValidObjectId(userId)) {
  //   return next(new AppError("Invalid user ID", 400));
  // }

  // try {
   
  //   const updatedUser = await User.findByIdAndUpdate(
  //     userId,
  //     { firstName: "harsh" }, 
  //     { new: true, runValidators: true }
  //   );

  //   if (!updatedUser) {
  //     return next(new AppError("No user found with that ID", 404));
  //   }

  //   res.status(200).json({
  //     status: "success",
  //     message: `${updatedUser.userType} updated successfully`,
  //     data: {
  //       user: updatedUser,
  //     },
  //   });
  // } catch (err) {
  //   next(err);
  // }
  // const userId = req.params.id;
  if(!mongoose.isValidObjectId(userId)){
    return next(new AppError("Invalid user ID",400));
  }
  const allowedUpdates = ["firstName","lastName","email", "mobile", "gender", "dateOfBirth", "city", "zipCode", "state", "status", "address", "photo", "country"];
  const updates = Object.keys(req.body);
  console.log(updates);
  const isValidOperation = updates.every((update) =>
  
  allowedUpdates.includes(update));
  if(!isValidOperation){
    return next(new AppError("Invalid updated!", 400));
  }
  try{
    const user = await User.findByIdAndUpdate(
      userId,
      req.body,
      {new:true, runValidators:true}
    );
    if(!user){
      return next(new AppError("No user found with that ID",404));
    }
    res.status(200).json({
      status:"success",
      message:`${user.userType} updated successfully`,
      data:{
        user,
      },
    });
  }catch (err){
    next(err);
  }
  // const filteredBody = filterObj(req.body, "name", "email");


  // let userData = { ...filteredBody, ...req.body };
  // if(userData.userType){
  //   userData.userType = 'user'
  // }
  // const user = await User.findById(req.params.id);

  // if (!user) {
  //   return next(new AppError("No user found with that ID", 404));
  // }
  // const updates = Object.keys(userData);
  // updates.forEach((update) => {
  //       if(update !== 'photo'){
  //         user[update] = userData[update]
  //       }
  // });
  // await user.save();

  // res.status(200).json({
  //   status: "success",
  //   message: `${user.userType} updated successfully`,
  //   data: {
  //     user,
  //   },
  // });
});

exports.deleteUser = catchAsync(async (req, res, next) => {
  const user = await User.findByIdAndDelete(req.params.id);

  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "Users deleted successfully",
    data: null,
  });
});

exports.expireCoupon = catchAsync(async (req, res, next) => {
  //Validate Data
  // const { error } = updateUserValidation(req.body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const user = await User.findById(req.params.id);
  user.coupons.push(req.body.coupons);
  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }
  await user.save();

  res.status(200).json({
    status: "success",
    message: `${user.userType} updated successfully`,
    data: {
      user,
    },
  });
});
exports.expireReward = catchAsync(async (req, res, next) => {
  //Validate Data
  // const { error } = updateUserValidation(req.body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const user = await User.findById(req.params.id);
  user.rewards = [];
  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }
  await user.save();

  res.status(200).json({
    status: "success",
    message: `${user.userType} updated successfully`,
    data: {
      user,
    },
  });
});

exports.getUserByRefCode = catchAsync(async (req, res, next) => {
  const data = req.params.id;
  const user = await User.aggregate([{ $match: { referralCode: data } }]);

  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: `User fetched successfully`,
    data: {
      user,
    },
  });
});

exports.addReward = catchAsync(async (req, res, next) => {
  //Validate Data
  // const { error } = updateUserValidation(req.body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const user = await User.findById(req.params.id);
  const reward = {
    title: "Referral Reward",
    amount: 10,
  };
  user.rewards.push(reward);
  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }
  await user.save();

  res.status(200).json({
    status: "success",
    message: `Reward purchased successfully`,
    data: {
      user,
    },
  });
});


exports.updatePhoto = catchAsync(async (req, res, next) => {
  const user = await User.findById(req.auth.id);
  if (!user) {
    return next(new AppError("No user found with that ID", 404));
  }
  user.photo = req.body.photo;
  await user.save();

  res.status(200).json({
    status: "success",
    message: `Photo updated successfully`,
    data: {
      user,
    },
  });
});
