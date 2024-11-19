const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

// validate user type feild
const customValidateForUserType = (value, helper) => {
  if (value === "admin" || value === "user") {
    return value;
  }
  return helper.error("please enter valid user type");
};

//Registration Validation
const registerValidation = (data) => {
  const schema = Joi.object({
    userName: Joi.string().required(),
    email: Joi.string().required().email(),
    password: Joi.string().required(),
    passwordConfirm: Joi.string().required(),
    userType: Joi.string().required().custom(customValidateForUserType),
  });
  return schema.validate(data);
};
const registerFirebaseValidation = (data) => {
  const schema = Joi.object({
    mobile: Joi.string().required(),
    firebaseToken: Joi.string().required(),
    userType: Joi.string().required().custom(customValidateForUserType),
    firebaseUID:Joi.string().required(),
  });
  return schema.validate(data);
};

//Login Validation
const loginValidation = (data) => {
  const schema = Joi.object({
    email: Joi.string().required().email(),
    password: Joi.string().required(),
    userType: Joi.string().required().custom(customValidateForUserType),
  });
  return schema.validate(data);
};

//Create User Validation
const createUserValidation = (data) => {
  const schema = Joi.object({
    firstName: Joi.string(),
    lastName: Joi.string(),
    userName: Joi.string().required(),
    email: Joi.string().required().email(),
    password: Joi.string().required(),
    passwordConfirm: Joi.string().required(),
    mobile: Joi.number(),
    gender: Joi.string(),
    dateOfBirth: Joi.date(),
    city: Joi.string(),
    state: Joi.string(),
    zipCode: Joi.string(),
    country: Joi.string(),
    status: Joi.string().required().custom(customValidateForStatus),
    address: Joi.string(),
    photo: Joi.string(),
    userType: Joi.string().required().custom(customValidateForUserType),
  });
  return schema.validate(data);
};

//Update User Validation
const updateUserValidation = (data) => {
  const schema = Joi.object({
    firstName: Joi.string(),
    lastName: Joi.string(),
    email: Joi.string().required().email(),
    password: Joi.string().required(),
    passwordConfirm: Joi.string(),
    mobile: Joi.number(),
    gender: Joi.string(),
    dateOfBirth: Joi.date(),
    city: Joi.string(),
    state: Joi.string(),
    zipCode: Joi.string(),
    country: Joi.string(),
    status: Joi.string().custom(customValidateForStatus),
    address: Joi.string(),
    photo: Joi.string(),
    userType: Joi.string().custom(customValidateForUserType),
  });
  return schema.validate(data);
};

module.exports.registerValidation = registerValidation;
module.exports.loginValidation = loginValidation;
module.exports.updateUserValidation = updateUserValidation;
module.exports.createUserValidation = createUserValidation;
module.exports.registerFirebaseValidation = registerFirebaseValidation;
