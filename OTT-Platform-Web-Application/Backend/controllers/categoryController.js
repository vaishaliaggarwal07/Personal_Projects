const Category = require("./../models/categoryModel");
const catchAsync = require("../utils/catchAsync");
const AppError = require("./../utils/appError");
const {
  addCategoryValidation,
  updateCategoryValidation,
} = require("./../utils/validations/categoryValidation");

//Routecategoryhanddlers
exports.getAllCategories = catchAsync(async (req, res) => {
  const categories = await Category.find();

  res.status(200).json({
    status: "success",
    message: "All categories fetch successfully",
    results: categories.length,
    data: {
      category: categories,
    },
  });
});

exports.getCategory = catchAsync(async (req, res, next) => {
  const category = await Category.findById(req.params.id);
  // Category.findOne({ _id: req.params.id })

  if (!category) {
    return next(new AppError("No category found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "get category successfully",
    data: {
      category,
    },
  });
});

exports.createCategory = catchAsync(async (req, res, next) => {
  //Validate Data
  const { error } = addCategoryValidation(req.body);
  if (error) return next(new AppError(error.details[0].message, 400));

  const newCategory = await Category.create(req.body);

  res.status(201).json({
    status: "success",
    message: "category created successfully",
    data: {
      category: newCategory,
    },
  });
});

exports.updateCategory = catchAsync(async (req, res, next) => {
  //Validate Data
  const { error } = updateCategoryValidation(req.body);
  if (error)
    return res.status(400).json({ error: true, msg: error.details[0].message });

  const category = await Category.findById(req.params.id);
  if (!category) {
    return next(new AppError("No category found with that ID", 404));
  }
  const updates = Object.keys(req.body);
  updates.forEach((update) => (category[update] = req.body[update]));
  await category.save();

  res.status(200).json({
    status: "success",
    message: "category updated successfully",
    data: {
      category,
    },
  });
});

exports.deleteCategory = catchAsync(async (req, res, next) => {
  const category = await Category.findByIdAndDelete(req.params.id);

  if (!category) {
    return next(new AppError("No category found with that ID", 404));
  }

  res.status(200).json({
    status: "success",
    message: "category deleted succesfully",
    data: null,
  });
});
