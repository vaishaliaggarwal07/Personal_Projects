const Joi = require("joi");

const addJoinUsValidation = (data) => {
    const schema = Joi.object({
      firstName: Joi.string().required(),
      middleName: Joi.string(),
      lastName: Joi.string().required,
      country: Joi.string(),
      state: Joi.string(),
      city: Joi.string(),
      email: Joi.string().required(),
      moviePass: Joi.string().required(),
      movieDescription: Joi.string().required(),
      userId: Joi.string().required(),
      status: Joi.string().required().custom(customValidateForStatus),
    });
    return schema.validate(data);
  };