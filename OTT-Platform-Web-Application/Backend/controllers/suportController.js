const catchAsync = require("../utils/catchAsync");
const Suport = require("../models/suportModel");
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads'); // Uploads will be stored in the 'uploads' folder
  },
  filename: function (req, file, cb) {
    // Define a unique file name
    cb(null, Date.now() + '-' + file.originalname);
  },
});

const upload = multer({ storage: storage });

// notification
exports.getSuport = catchAsync(async (req, res, next) => {
  const support = await Suport.findById(req.params.id);
  // support.findOne({ _id: req.params.id })

  if (!support) {
    return next(new AppError("No support found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "support fetched successfully",
    data: {
      support,
    },
  });
});

exports.createSuport = upload.single('attachedFile'), async (req, res, next) => {
  try {
    // Access the uploaded file using req.file
    if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }

    // Access other form data fields
    const { title, description, email } = req.body;

    const base64Data = req.body.attachedFile;
    const dataBuffer = Buffer.from(base64Data, 'base64');

    const fileName = Date.now() + '-' + req.file.originalname;

    fs.writeFileSync('uploads/' + fileName, dataBuffer);
    // Example of saving to MongoDB:
    const support = new Suport({
      title,
      description,
      email,
      attachedFile: 'uploads/' + fileName, // Store the file path in your model
    });

    await support.save();

    return res.status(201).json({
      status: 'success',
      message: 'Support created successfully!',
      data: {
        support,
      },
    });
  } catch (error) {
    return res.status(500).json({ message: 'Internal server error' });
  }
};

// exports.createSuport = catchAsync(async (req, res, next) => {
//   const suport = await Suport.create(req.body);

//   res.status(201).json({
//     status: "success",
//     message: "created successfully!",
//     data: {
//       suport: suport,
//     },
//   });
// });

exports.getAllSuport = catchAsync(async (req, res) => {
  const suport = await Suport.find();

  res.status(200).json({
    status: "success",
    message: "Notification fetched successfully!",
    results: suport.length,
    data: {
      suport: suport,
    },
  });
});
