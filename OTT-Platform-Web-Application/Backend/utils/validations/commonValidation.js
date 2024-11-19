const customValidateForStatus = (value, helper) => {
  if (value === "Active" || value === "Inactive") {
    return value;
  }
  return helper.error("please enter valid Status type Active/Inactive");
};
module.exports.customValidateForStatus = customValidateForStatus;
