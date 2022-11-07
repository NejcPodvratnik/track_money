const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userModel = new Schema({
  email: { type: String, required: true, unique: true },
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  balance: { type: Number, default: 0.0}
});

userModel.set('toJSON', { getters: true });
userModel.options.toJSON.transform = (doc, ret) => {
  const obj = { ...ret };
  delete obj._id;
  delete obj.__v;
  delete obj.password;
  return obj;
};

userModel.methods = {
  updateBalance: function (flow, value) {
    if (flow == "inflow")
      this.balance += parseInt(value)
    else if (flow == "outflow")
      this.balance -= parseInt(value);
    return this.save();
  },
};

module.exports = mongoose.model('user', userModel);
