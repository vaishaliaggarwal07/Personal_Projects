const mongoose = require("mongoose");

const joinUsSchema = new mongoose.Schema({
  firstName: {
    type: String,
    required: true,
  },
  middleName: {
    type: String,
  },
  lastName: {
    type: String,
    required: true,
  },
  country: {
    type: String,
  },
  state: {
    type: String,
  },
  city: {
    type: String,
  },
  pincode: {
    type: String,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    
  },
  mobileNumber: {
    type: String,
    required: true,
    unique: true,
  },
  userType: {
    type: String,
    enum: ["Director", "Cinematographer", "Actor","Actress", "Technician", "Others"],
    required: true,
  },
  otherUserType: {
    type: String,
    // Only required if userType is "other"
  },
  showReels: {
    type: String,
    // Only required if userType is "actor" or "Technician"
  },
});

const JoinUs = mongoose.model("JoinUs", joinUsSchema,"joinUs");

module.exports = JoinUs;
