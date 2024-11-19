const mongoose = require("mongoose");

const rewardSchema = new mongoose.Schema(
  {
    title: {
      type: String,
    },
    subtitle: {
      type: String,
    },
    couponCode: {
      type: String,
    },
    amount: {
      type: Number,
    },
    description: {
      type: String,
    },
    expireDate: {
      type: Date,
    },
    userLimit: {
      type: String,
    },
    status: {
      type: String,
      default: "Active",
    },
    movieId: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Movie",
        required: [false, "Movie must belong to a user"],
      },
    ],
    createdAt: {
      type: Date,
      default: Date.now,
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

rewardSchema.pre(/^find/, function (next) {
  this.populate({
    path: "movieId",
    select: ["title"],
  });
  next();
});
// findByIdAndUpdate
// findByIdAndDelete
// rewardSchema.pre(/^findOneAnd/, async function (next) {
//   this.r = await this.findOne();
//   // console.log(this.r);
//   next();
// });

const Reward = mongoose.model("Reward", rewardSchema);

module.exports = Reward;
