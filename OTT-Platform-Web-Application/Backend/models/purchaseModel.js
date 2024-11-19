const mongoose = require("mongoose");
var format = require("date-format");

const purchesSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [false, "User must belong to a user"],
    },
    movieId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Movie",
      required: [false, "Movie must belong to a Movie"],
    },
    transitionId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Movie_Transactions",
      required: [
        false,
        "MovieTranscations must belong to a Movie_Transactions",
      ],
    },
    stream: {
      type: Boolean,
      default: false,
    },
    expiredAt: {
      type: Date,
      default: format.asString(
        format.ISO8601_WITH_TZ_OFFSET_FORMAT,
        new Date(new Date().setFullYear(new Date().getFullYear() + 1))
      ),
    },
    expired: {
      type: Boolean,
      default: false,
    },
    createdAt: {
      type: Date,
      default: Date.now(),
    },
    updatedAt: {
      type: Date,
      default: Date.now(),
    },
  },
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);

purchesSchema.index({ movie: 1, user: 1, transition: 1 }, { unique: false });

purchesSchema.pre(/^find/, function (next) {
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
      "isTrend",
      "dhaakadRating",
      "languages",
      "offerPrice",
      "description",
      "banners",
      "releaseDate",
      "expireDate",
    ],
  });
  this.populate({
    path: "transitionId",
    select: [
      "amount",
      "receipt",
      "currency",
      "streamed",
      "order_id",
      "payment_id",
      "movie_booking_type",
      "status",
    ],
  });
  next();
});

const Purchase = mongoose.model("Purchase", purchesSchema);

module.exports = Purchase;
