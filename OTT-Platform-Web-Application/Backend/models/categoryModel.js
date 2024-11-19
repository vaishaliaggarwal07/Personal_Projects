const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema(
  {
    title: {
      type: String,
      unique: true,
    },
    status: {
      type: String,
      default: "Active",
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
    updatedAt:{
      type:Date,
      default:Date.now
    }
  },
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);
categorySchema.pre('save', function(next) {
  this.updatedAt = Date.now();
  next();
});

// findByIdAndUpdate
// findByIdAndDelete
// categorySchema.pre(/^findOneAnd/, async function (next) {
//   this.r = await this.findOne();
//   // console.log(this.r);
//   next();
// });

const Category = mongoose.model("Category", categorySchema);

module.exports = Category;
