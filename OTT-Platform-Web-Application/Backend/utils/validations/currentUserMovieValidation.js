//Login Validation
const Joi = require("joi");

module.exports = {
    upsertValidation: (data) => {
        const schema = Joi.object({
            movieId: Joi.string().required(),
            currentTime: Joi.number().required(),
        });
        return schema.validate(data);
    }
}
