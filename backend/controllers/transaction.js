const Transaction = require('../models/transaction');
const { body, validationResult } = require('express-validator');
const User = require('../models/user');


exports.loadTransactions = async (req, res, next, id) => {
  try {
    const transaction = await Transaction.findById(id);
    if (!transaction) return res.status(404).json({ message: 'Transaction not found.' });
    req.transaction = transaction;
  } catch (error) {
    if (error.name === 'CastError') return res.status(400).json({ message: 'Invalid transaction id.' });
    return next(error);
  }
  next();
};

exports.createTransaction = async (req, res, next) => {
    const result = validationResult(req);
    if (!result.isEmpty()) {
      const errors = result.array({ onlyFirstError: true });
      return res.status(422).json({ message: errors[0].param + " " + errors[0].msg });
    }
    try {
      const { value, paymentMethod, flow, category, description } = req.body;
      const owner = req.user.id
      const user = await User.findById(owner);
      user.updateBalance(flow, value);

      const transaction = await Transaction.create({
        owner,
        value,
        paymentMethod,
        flow,
        category,
        description
      });
      res.status(201).json(transaction);
    } catch (error) {
      next(error);
    }
  };
  
  exports.listTransactions = async (req, res, next) => {
    const result = validationResult(req);
    if (!result.isEmpty()) {
      const errors = result.array({ onlyFirstError: true });
      return res.status(422).json({ message: errors[0].param + " " + errors[0].msg });
    }
    
    try {
      var { startDate = new Date(-8640000000000000), endDate = new Date(8640000000000000), flow = "all" } = req.body;

      if (endDate < startDate)
        return res.status(400).json({ message: "Start date cannot be set after end date." });

      filters = { date: { $gt: startDate, $lt: endDate }, owner: req.user.id }
      if (flow != "all")
        filters = {...filters, flow: flow}
      const transactions = await Transaction.find(filters).sort("-date");
      res.json(transactions);
    } catch (error) {
      next(error);
    }
  };
  
  exports.findTransaction = async (req, res, next) => {
      try {
        res.json(req.transaction);
      } catch (error) {
        next(error);
      }
    };
  
  exports.updateTransaction = async (req, res, next) => {
    const result = validationResult(req);
    if (!result.isEmpty()) {
      const errors = result.array({ onlyFirstError: true });
      return res.status(422).json({ message: errors[0].param + " " + errors[0].msg });
    }
    try {
      const { value, paymentMethod, flow, category, description } = req.body;
      const user = await User.findById(req.user.id);
      var newValue = (req.transaction.flow == "inflow") ? parseInt(req.transaction.value) * -1 : parseInt(req.transaction.value);
      newValue += (flow == "inflow") ? parseInt(value) : parseInt(value) * -1;
      user.updateBalance("inflow", newValue);
      const transaction = await req.transaction.updateTransaction(value, paymentMethod, flow, category, description);
      res.json(transaction);
    } catch (error) {
      next(error);
    }
  };

  exports.deleteTransaction = async (req, res, next) => {
      try {
        const user = await User.findById(req.transaction.owner);
        user.updateBalance(req.transaction.flow, parseInt(req.transaction.value) * -1);
        await req.transaction.remove();
        res.status(200).json({ message: 'Your transaction is successfully deleted.' });
      } catch (error) {
        next(error);
      }
  };

exports.filterValidate = [
  body('startDate')
    .exists()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isDate()
    .withMessage('must be a date'),

  body('endDate')
    .exists()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isDate()
    .withMessage('must be a date'),

  body('flow')
    .exists()
    .withMessage('is required')
    
    .notEmpty()
    .withMessage('cannot be blank')
  
    .isIn(['inflow', 'outflow','all'])
    .withMessage('contains invalid value'),
];
  
exports.transactionValidate = [
  body('value')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isCurrency({allow_negatives: false, thousands_separator: ''})
    .withMessage('must be in a valid currency format'),

  body('paymentMethod')
    .exists()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank'),

  body('flow')
    .exists()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isIn(['inflow', 'outflow'])
    .withMessage('contains invalid value'),

    body('category')
    .exists()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank'),

    body('description')
    .exists()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank'),

];
