const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

//Movie Validation
const addUserMovieValidation = (data) => {
  const schema = Joi.object({
    name: Joi.string().required(),
    email: Joi.string().required(),
    productionHouse: Joi.string(),
    language: Joi.string().required(),
    trailerVideo: Joi.string().required(),
    movieVideo: Joi.string().required(),
    trailerPass: Joi.string().required(),
    moviePass: Joi.string().required(),
    movieDescription: Joi.string().required(),
    userId: Joi.string().required(),
    status: Joi.string().required().custom(customValidateForStatus),
  });
  return schema.validate(data);
};

const updateUserMovieValidation = (data) => {
  const schema = Joi.object({
    name: Joi.string().required(),
    email: Joi.string().required(),
    productionHouse: Joi.string(),
    language: Joi.string().required(),
    trailerVideo: Joi.string().required(),
    movieVideo: Joi.string().required(),
    trailerPass: Joi.string().required(),
    moviePass: Joi.string().required(),
    movieDescription: Joi.string().required(),
    userId: Joi.string().required().required(),
    status: Joi.string().custom(customValidateForStatus).required(),
  });
  return schema.validate(data);
};

module.exports.addUserMovieValidation = addUserMovieValidation;
module.exports.updateUserMovieValidation = updateUserMovieValidation;
