const Cast = require("./../models/castModel");
const catchAsync = require("../utils/catchAsync");
const multer = require("multer");
const sharp = require("sharp");
const AppError = require("./../utils/appError");

// const {
//   addCastValidation,
//   updateCastValidation,
// } = require("./../utils/validations/castValidation");

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

exports.uploadCastPhoto = upload.single("photo");

//Resizing Image
exports.resizeCastPhoto = catchAsync(async (req, res, next) => {
  if (!req.file) return next();
  const fileName = `cast-profile-${Date.now()}.jpeg`;
  const filePath = "public/img/casts";

  await sharp(req.file.buffer)
    .resize(500, 500)
    .toFormat("jpeg")
    .jpeg({ quality: 90 })
    .toFile(`${filePath}/${fileName}`);

  req.body.photo = `http://localhost:${process.env.PORT}/img/casts/${fileName}`;
  next();
});

//Routecasthanddlers
exports.getAllCasts = catchAsync(async (req, res) => {
  const casts = await Cast.find();

  res.status(200).json({
    status: "success",
    message: "casts get successfully",
    results: casts.length,
    data: {
      cast: casts,
    },
  });
});

exports.getCast = catchAsync(async (req, res, next) => {
  const castIdArr = req.params.id.split(",");
  // const cast = await Cast.findById(req.params.id);
  const cast = await Cast.find({ _id: castIdArr });

  if (!cast) {
    return next(new AppError("No cast found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "cast fetch successfully",
    data: {
      cast,
    },
  });
});

exports.createCast = catchAsync(async (req, res, next) => {
  //Validate Data

  const body = req.body;

  // const { error } = addCastValidation(body);
  // if (error) return next(new AppError(error.details[0].message, 400));
  const d = await Cast.find({
    $and: [
      { firstName: req.body.firstName },
      { lastName: req.body.lastName },
      { dateOfBirth: req.body.dateOfBirth },
      { gender: req.body.gender },
      { address: req.body.address },
    ],
  });
  if (d.length > 0) {
    return next(new AppError("cast could not duplicate", 401));
  }
  const newCast = await Cast.create(req.body);

  res.status(201).json({
    status: "success",
    message: "cast created successfully",
    data: {
      cast: newCast,
    },
  });
});

exports.updateCast = catchAsync(async (req, res, next) => {
  //Validate Data
  // const { error } = updateCastValidation(req.body);
  // if (error) return next(new AppError(error.details[0].message, 400));

  const cast = await Cast.findById(req.params.id);
  const updates = Object.keys(req.body);
  if (!cast) {
    return next(new AppError("No cast found with that ID", 404));
  }
  updates.forEach((update) => (cast[update] = req.body[update]));
  await cast.save();

  res.status(200).json({
    status: "success",
    message: "cast updated successfully",
    data: {
      cast,
    },
  });
});

exports.deleteCast = catchAsync(async (req, res, next) => {
  const cast = await Cast.findByIdAndDelete(req.params.id);

  if (!cast) {
    return next(new AppError("No cast found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "cast deleted successfully",
    data: null,
  });
});
