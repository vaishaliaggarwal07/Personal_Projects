const mongoose = require("mongoose");

const suportSchema = new mongoose.Schema(
  {
    title: {
      type: String,
    },
    description: {
      type: String,
    },
    email: {
      type: String,
    },
    attachedFile: {
      originalname: String, // Original name of the file
      fileId: mongoose.Schema.Types.ObjectId, // Reference to the file in GridFS
      // Add other metadata fields as needed
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

const suport = mongoose.model("suport", suportSchema);

module.exports = suport;
