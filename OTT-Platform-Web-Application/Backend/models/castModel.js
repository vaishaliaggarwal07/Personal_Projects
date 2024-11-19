const mongoose = require("mongoose");
const {appendSASToField} = require("../service/azureService");

const castSchema = new mongoose.Schema(
  {
    firstName: {
      type: String,
      // unique: true,
    },
    lastName: {
      type: String,
      // unique: true,
    },
    photo: {
      type: String,
    },
    description: {
      type: String,
    },
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

// findByIdAndUpdate
// findByIdAndDelete
// castSchema.pre(/^findOneAnd/, async function (next) {
//   this.r = await this.findOne();
//   // console.log(this.r);
//   next();
// });
castSchema.pre("save", function (next) {
  this.updatedAt = Date.now();
  next();
});

castSchema.post(/^find/, function (recordList, next) {
    if(recordList){
        if(recordList.length>0){
            for(let record of recordList){
                if(record){
                    appendSASToField(record,'photo');
                }
            }
        }else{
            appendSASToField(recordList,'photo');
        }
    }
    next();
});

const Cast = mongoose.model("Cast", castSchema);

module.exports = Cast;
