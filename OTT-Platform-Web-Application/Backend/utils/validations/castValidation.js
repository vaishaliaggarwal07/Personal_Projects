const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

//Create Cast Validation
const addCastValidation = (data) => {
  const schema = Joi.object({
    firstName: Joi.string(),
    lastName: Joi.string(),
    gender: Joi.string(),
    dateOfBirth: Joi.date(),
    city: Joi.string(),
    state: Joi.string(),
    role: Joi.string(),
    status: Joi.string().required().custom(customValidateForStatus),
    photo: Joi.string().required(),
    address: Joi.string(),
    description: Joi.string(),
  });
  return schema.validate(data);
};

//Update Cast Validation
const updateCastValidation = (data) => {
  const schema = Joi.object({
    firstName: Joi.string(),
    lastName: Joi.string(),
    gender: Joi.string(),
    dateOfBirth: Joi.date(),
    city: Joi.string(),
    state: Joi.string(),
    role: Joi.string(),
    status: Joi.string().custom(customValidateForStatus),
    photo: Joi.string(),
    address: Joi.string(),
    description: Joi.string(),
  });
  return schema.validate(data);
};

module.exports.addCastValidation = addCastValidation;
module.exports.updateCastValidation = updateCastValidation;
