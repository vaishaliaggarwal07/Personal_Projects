const Joi = require("joi");
const { customValidateForStatus } = require("./commonValidation");

//Movie Validation
const addMovieValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    duration: Joi.string(),
    categories: Joi.string(),
    subtitles: Joi.array(),
    banners: Joi.array(),
    trailerUrl: Joi.string(),
    movieUrl: Joi.string(),
    languages: Joi.string(),
    dhaakadRating: Joi.string(),
    ageGroup: Joi.string(),
    casts: Joi.string(),
    price: Joi.number(),
    releaseYear: Joi.number(),
    offerPrice: Joi.number(),
    description: Joi.string(),
    subDescription: Joi.string(),
    toolTip: Joi.string(),
    status: Joi.string().required().custom(customValidateForStatus),
    castIds: Joi.string().required(),
    isFeatured: Joi.boolean(),
    releaseDate: Joi.date(),
    isTrend: Joi.boolean(),
    movieVideo: Joi.string(),
    trailerVideo: Joi.string(),
  });
  return schema.validate(data);
};

const updateMovieValidation = (data) => {
  const schema = Joi.object({
    title: Joi.string(),
    duration: Joi.string(),
    categories: Joi.string(),
    subtitles: Joi.array(),
    banners: Joi.array(),
    languages: Joi.string(),
    dhaakadRating: Joi.string(),
    ageGroup: Joi.string(),
    casts: Joi.string(),
    price: Joi.number(),
    offerPrice: Joi.number(),
    releaseYear: Joi.number(),
    description: Joi.string(),
    subDescription: Joi.string(),
    toolTip: Joi.string(),
    status: Joi.string().custom(customValidateForStatus),
    castIds: Joi.string(),
    isFeatured: Joi.boolean(),
    releaseDate: Joi.date(),
    isTrend: Joi.boolean(),
    movieVideo: Joi.string(),
    trailerVideo: Joi.string(),
    trailerUrl: Joi.string(),
    movieUrl: Joi.string(),
  });
  return schema.validate(data);
};

const uploadVideoValidations = (data) => {
  const schema = Joi.object({
    video: Joi.array().required(),
    type: Joi.string().required(),
  });
  return schema.validate(data);
};

const createOrderValidation = (data) => {
  const schema = Joi.object({
    userId: Joi.string().required(),
    movieId: Joi.string().required(),
    amount: Joi.number().required(),
    currency: Joi.string().required(),
    receipt: Joi.string().required(),
    notes: Joi.object(),
    streamed: Joi.boolean(),
  });
  return schema.validate(data);
};

const verifyOrderBody = (data) => {
  const schema = Joi.object({
    order_id: Joi.string().required(),
    payment_id: Joi.string().required(),
    movie_booking_type: Joi.string().required(),
  });
  return schema.validate(data);
};

const preBookedMoviesValidations = (data) => {
  const schema = Joi.object({
    userid: Joi.string().required(),
  });
  return schema.validate(data);
};

module.exports.addMovieValidation = addMovieValidation;
module.exports.updateMovieValidation = updateMovieValidation;
module.exports.uploadVideoValidations = uploadVideoValidations;
module.exports.createOrderValidation = createOrderValidation;
module.exports.verifyOrderBody = verifyOrderBody;
module.exports.preBookedMoviesValidations = preBookedMoviesValidations;
