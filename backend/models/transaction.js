const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const transactionSchema = new Schema({
  owner: { 
    type: Schema.Types.ObjectId,
    ref: 'user',
    required: true
  },
  value: { type: Number, required: true },
  paymentMethod: { type: String, required: true },
  flow: { type: String, required: true },
  category: { type: String, required: true },
  description: { type: String, required: true },
  date: { type: Date, default: Date.now() },
});

transactionSchema.set('toJSON', { getters: true });

transactionSchema.options.toJSON.transform = (doc, ret) => {
  const obj = { ...ret };
  delete obj._id;
  delete obj.__v;
  return obj;
};

transactionSchema.methods = {
  updateTransaction: function (value, paymentMethod, flow, category, description) {
    this.value = value;
    this.paymentMethod = paymentMethod;
    this.flow = flow;
    this.category = category;
    this.description = description;
    this.date = Date.now();
    return this.save();
  },
};

module.exports = mongoose.model('Transaction', transactionSchema);
