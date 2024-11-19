const mongoose = require("mongoose");
const Movie = require("./movieModel");

const reviewSchema = new mongoose.Schema(
  {
    review: {
      type: String,
      required: [true, "Review can not be empty!"],
    },
    description: {
      type: String,
    },
    rating: {
      type: Number,
      min: 1,
      max: 5,
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
    // movie: {
    //   type: mongoose.Schema.ObjectId,
    //   ref: "Movie",
    //   required: [true, "Review must belong to a Movie."],
    // },
    movieId: {
      type: mongoose.Schema.ObjectId,
      ref: "Movie",
      required: [false, "Review must belong to a Movie."],
    },
    user: {
      type: mongoose.Schema.ObjectId,
      ref: "User",
      required: [true, "Review must belong to a user"],
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
    isApproved: {
      type: Boolean,
      default: false,
    },
  },
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);

reviewSchema.index({ movie: 1 }, { unique: false });

reviewSchema.pre(/^find/, function (next) {
  // this.populate({
  //   path: 'movie',
  //   select: 'name'
  // }).populate({
  //   path: 'user',
  //   select: 'name photo'
  // });

  this.populate({
    path: "user",
    select: ["firstName", "lastName", "photo", "userName"],
  });

  this.populate({
    path: "movieId",
    select: ["title"],
  });
  next();
});

reviewSchema.statics.calcAverageRatings = async function (movieId) {
  try {
    const stats = await this.aggregate([
      {
        $match: { movieId: movieId },
      },
      {
        $group: {
          _id: "$movieId",
          rating: { $avg: "$rating" },
        },
      },
    ]);

    if (stats.length > 0) {
      await Movie.findByIdAndUpdate(movieId, {
        averageRating: stats[0].rating,
      });
    }
  } catch (err) {
    console.log("getting error", err);
  }
};

reviewSchema.post("save", function () {
  // this points to current review
  this.updatedAt = Date.now();
  this.constructor.calcAverageRatings(this.movieId);
});

// findByIdAndUpdate
// findByIdAndDelete
// reviewSchema.pre(/^findOneAnd/, async function (next) {
//   this.r = await this.findOne();
//   // console.log(this.r);
//   next();
// });

// reviewSchema.post(/^findOneAnd/, async function () {
//   // await this.findOne(); does NOT work here, query has already executed
//   await this.r.constructor.calcAverageRatings(this.r.movie);
// });

const Review = mongoose.model("Review", reviewSchema);

module.exports = Review;
