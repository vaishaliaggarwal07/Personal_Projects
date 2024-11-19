const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

//Create Language Validation
const addLanguageValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    status: Joi.string().required().custom(customValidateForStatus),
  });
  return schema.validate(data);
};

//Update Language Validation
const updateLanguageValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    status: Joi.string().custom(customValidateForStatus),
  });
  return schema.validate(data);
};

module.exports.addLanguageValidation = addLanguageValidation;
module.exports.updateLanguageValidation = updateLanguageValidation;
