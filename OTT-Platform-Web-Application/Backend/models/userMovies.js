const mongoose = require("mongoose");
const slugify = require("slugify");
// const validator = require('validator');

const userMovieSchema = new mongoose.Schema(
  {
    name: {
      type: String,
    },
    email: {
      type: String,
    },
    productionHouse: {
      type: String,
    },
    language: {
      type: String,
    },
    trailerVideo: {
      type: String,
    },
    movieVideo: {
      type: String,
    },
    trailerPass: {
      type: String,
    },
    moviePass: {
      type: String,
    },
    movieDescription: {
      type: String,
    },
    userId: {
      type: String,
    },
    createdAt: {
      type: Date,
      default: Date.now(),
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
    status: {
      type: String,
      default: "Active",
    },
  },
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);

// movieSchema.virtual("durationWeeks").get(function () {
//   return this.duration / 7;
// });

// DOCUMENT MIDDLEWARE: runs before .save() and .create()
userMovieSchema.pre("save", function (next) {
  this.updatedAt = Date.now();
  // this.slug = slugify(this.title, { lower: true });
  next();
});

userMovieSchema.pre(/^find/, function (next) {
  // this.find({ secretMovie: { $ne: true } });

  this.start = Date.now();
  next();
});

userMovieSchema.post(/^find/, function (docs, next) {
  console.log(`Query took ${Date.now() - this.start} milliseconds!`);
  next();
});

// AGGREGATION MIDDLEWARE
userMovieSchema.pre("aggregate", function (next) {
  // this.pipeline().unshift({ $match: { secretMovie: { $ne: true } } });

  // console.log(this.pipeline());
  next();
});

const UserMovie = mongoose.model("User_Movies", userMovieSchema);

module.exports = UserMovie;
