const Razorpay = require("razorpay");
const crypto = require("crypto");

const razorpayInstance = new Razorpay({
  // Replace with your key_id
  key_id: process.env.RAZOR_PAY_KEY_ID,

  // Replace with your key_secret
  key_secret: process.env.RAZORPAY_SECRET_KEY,
});

const verifyTranscations = async (order_id, payment_id, razorpay_signature) => {
  let hmac = crypto.createHmac("sha256", process.env.RAZORPAY_SECRET_KEY);

  hmac.update(order_id + "|" + payment_id);

  const generated_signature = hmac.digest("hex");

  return generated_signature;

  // let order = await razorpayInstance.orders.create({amount, currency, receipt, notes})
  return null;
};

const createOrder = async (amount, currency, receipt, notes, streamed) => {
  let order = await razorpayInstance.orders.create({
    amount,
    currency,
    receipt,
    notes,
    streamed,
  });
  return order;
};
const razorpayOrder = async (amount, currency, orderId, notes, receipt) => {
  let order = await razorpayInstance.orders.create({
    amount,
    currency,
    orderId,
    notes,
    receipt,
  });
  return order;
};

const preBookMovie = async (amount, currency, transcation_id) => {
  let order = await razorpayInstance.orders.create({
    amount,
    currency,
    receipt,
    notes,
  });
  return order;
};

module.exports = {
  verifyTranscations,
  razorpayOrder,
  createOrder,
};
