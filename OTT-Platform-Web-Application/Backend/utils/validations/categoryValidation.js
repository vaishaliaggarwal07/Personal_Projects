const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

//Create Category Validation
const addCategoryValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    status: Joi.string().required().custom(customValidateForStatus),
  });
  return schema.validate(data);
};

//Update Category Validation
const updateCategoryValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    status: Joi.string().custom(customValidateForStatus),
  });
  return schema.validate(data);
};

module.exports.addCategoryValidation = addCategoryValidation;
module.exports.updateCategoryValidation = updateCategoryValidation;
