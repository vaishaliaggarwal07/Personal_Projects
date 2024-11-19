const mongoose = require("mongoose");
const slugify = require("slugify");
// const validator = require('validator');
var format = require("date-format");
const {appendSASToBanner} = require("../service/azureService");

const userTranscationsSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [false, "User must belong to a user"],
    },
    movieId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Movie",
      required: [false, "Movie must belong to a user"],
    },
    amount: {
      type: String,
    },
    currency: {
      type: String,
    },
    receipt: {
      type: Number,
    },
    streamed: {
      type: Boolean,
      default: false,
    },
    startedAt: {
      type: Date,
    },
    expired: {
      type: Boolean,
      default: false,
    },
    notes: {
      type: Object,
    },
    order_id: {
      type: String,
    },
    payment_id: {
      type: String,
    },
    movie_booking_type: {
      type: String,
    },
    status: {
      type: String,
      default: "Pending",
    },
    createdAt: {
      type: Date,
      default: Date.now(),
    },
    updatedAt: {
      type: Date,
      default: Date.now,
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

userTranscationsSchema.pre(/^find/, function (next) {
  this.populate({
    path: "userId",
    select: [
      "userName",
      "email",
      "mobile",
      "userType",
      "dateOfBirth",
      "status",
    ],
  });
  this.populate({
    path: "movieId",
    select: [
      "price",
      "title",
      "casts",
      "categories",
      "isTrend",
      "dhaakadRating",
      "languages",
      "offerPrice",
      "description",
      "banners",
      "releaseDate",
      "expireDate",
      "subtitles",
      "subDescription",
      "duration",
      "movieUrl",
      "trailerUrl",
    ],
  });
  next();
});
// DOCUMENT MIDDLEWARE: runs before .save() and .create()
userTranscationsSchema.pre("save", function (next) {
  this.updatedAt = Date.now();
  // this.slug = slugify(this.title, { lower: true });
  next();
});

userTranscationsSchema.pre(/^find/, function (next) {
  // this.find({ secretMovie: { $ne: true } });

  this.start = Date.now();
  next();
});

userTranscationsSchema.post(/^find/, function (recordList, next) {
    if(recordList){
        if(recordList.length>0){
            for(let record of recordList){
                if(record.movieId){
                    appendSASToBanner(record.movieId);
                }
            }
        }else{
            appendSASToBanner(recordList.movieId);
        }
    }

  next();
});

// AGGREGATION MIDDLEWARE
userTranscationsSchema.pre("aggregate", function (next) {
  // this.pipeline().unshift({ $match: { secretMovie: { $ne: true } } });

  // console.log(this.pipeline());
  next();
});

const MovieTranscations = mongoose.model(
  "Movie_Transactions",
  userTranscationsSchema
);

module.exports = MovieTranscations;
