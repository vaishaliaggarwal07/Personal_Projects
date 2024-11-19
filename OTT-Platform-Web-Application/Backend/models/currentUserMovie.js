const mongoose = require("mongoose");
const Schema = mongoose.Schema
const ObjectId = Schema.Types.ObjectId

const currentUserMovieSchema = new mongoose.Schema(
    {
        movieId: {
            type: String,
            required:true,
        },
        userId: {
            type: String,
            required:true,
        },
        currentTime:{
            type:Number,
            required:true,
        },
    },
    {
        timestamps:true,
        toJSON: { virtuals: true },
        toObject: { virtuals: true },
    }
);

const CurrentUserMovie = mongoose.model("current_user_movie", currentUserMovieSchema);

module.exports = CurrentUserMovie;
