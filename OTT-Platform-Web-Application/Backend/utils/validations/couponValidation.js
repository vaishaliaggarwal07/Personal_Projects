const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

//Create Category Validation
const addCouponValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    subtitle: Joi.string(),
    couponCode: Joi.string(),
    amount: Joi.number().required(),
    description: Joi.string(),
    status: Joi.string().required().custom(customValidateForStatus),
    expireDate: Joi.date(),
    userLimit: Joi.string(),
    movieId: Joi.array(),
  });
  return schema.validate(data);
};

//Update Category Validation
const updateCouponValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    subtitle: Joi.string(),
    couponCode: Joi.string(),
    amount: Joi.number().required(),
    description: Joi.string(),
    status: Joi.string().custom(customValidateForStatus),
    expireDate: Joi.date(),
    userLimit: Joi.string(),
    movieId: Joi.array(),
  });
  return schema.validate(data);
};

module.exports.addCouponValidation = addCouponValidation;
module.exports.updateCouponValidation = updateCouponValidation;
