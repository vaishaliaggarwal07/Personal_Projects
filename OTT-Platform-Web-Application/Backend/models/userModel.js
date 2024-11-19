const crypto = require("crypto");
const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const {appendSASToField} = require("../service/azureService");
const salt = bcrypt.genSalt();

const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
  },
  lastName: {
    type: String,
  },
  userName: {
    type: String,
  },
  email: {
    type: String,
  },
  referralCode: {
    type: String,
  },
  idReferralCode: {
    type: Boolean,
    default: false,
  },
  rewards: [
    {
      title: {
        type: String,
      },
      amount: {
        type: Number,
      },
    },
  ],
  coupons: {
    type: Array,
  },
  otp: {
    type: Number,
  },
  expiryotp: {
    type: Date,
  },

  password: {
    type: String,
  },
  passwordConfirm: {
    type: String,
    validate: {
      // This only works on CREATE and SAVE!!!
      validator: function (el) {
        return el === this.password;
      },
      message: "Passwords do not match!",
    },
  },
  mobile: {
    type: String,
    required: true,
    unique: [true],
  },
  gender: {
    type: String,
  },
  dateOfBirth: {
    type: Date,
  },
  city: {
    type: String,
  },
  releasedBookedMovies: {
    type: Array,
  },
  preBookedMovies: {
    type: Array,
  },
  country: {
    type: String,
  },
  zipCode: {
    type: String,
  },
  state: {
    type: String,
  },
  status: {
    type: String,
    default: "Inactive",
  },
  photo: {
    type: String,
  },
  address: {
    type: String,
  },
  userType: {
    type: String,
  },
  sourceoflogin: {
    type: String,
    enum: ["M", "E"],
    default: null, // Set a default value, or you can omit this line if there's no default value.
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
  firebaseId: String,
  passwordChangedAt: Date,
  passwordResetToken: String,
  passwordResetExpires: Date,
});

userSchema.pre("save", async function (next) {
  // Only run this function if password was actually modified
  if (!this.isModified("password")) return next();

  if(this.password){
    // Hash the password with cost of 12
    this.password = await bcrypt.hash(this.password, 12);
  }

  // Delete passwordConfirm field
  this.passwordConfirm = undefined;
  next();
});

userSchema.pre("save", function (next) {
  if (!this.isModified("password") || this.isNew) return next();

  if(this.password){
    this.passwordChangedAt = Date.now() - 1000;
  }

  next();
});

userSchema.post(/^find/, function (recordList, next) {
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

userSchema.methods.correctPassword = async function (
  candidatePassword,
  userPassword
) {
  return await bcrypt.compare(candidatePassword, userPassword);
};

userSchema.methods.changedPasswordAfter = function (JWTTimestamp) {
  if (this.passwordChangedAt) {
    const changedTimestamp = parseInt(
      this.passwordChangedAt.getTime() / 1000,
      10
    );

    return JWTTimestamp < changedTimestamp;
  }

  // False means NOT changed
  return false;
};

userSchema.methods.createPasswordResetToken = function () {
  const resetToken = crypto.randomBytes(32).toString("hex");

  this.passwordResetToken = crypto
    .createHash("sha256")
    .update(resetToken)
    .digest("hex");

  this.passwordResetExpires = Date.now() + 10 * 60 * 1000;

  return resetToken;
};

const User = mongoose.model("User", userSchema);

module.exports = User;
