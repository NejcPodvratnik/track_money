const {
  validateSignUp,
  validateAuthenticate,
  signup,
  authenticate,
  find
} = require('./controllers/user');

const {
  loadTransactions,
  transactionValidate,
  filterValidate,
  createTransaction,
  listTransactions,
  findTransaction,
  updateTransaction,
  deleteTransaction
} = require('./controllers/transaction');

const requireAuth = require('./middlewares/requireAuth');
const transactionAuth = require('./middlewares/transactionAuth');

const router = require('express').Router();

//user
router.post('/signup', validateSignUp, signup);
router.post('/authenticate', validateAuthenticate, authenticate);
router.get('/user/:id', find);

//transactions
router.param('transaction', loadTransactions);
router.post('/transaction', [requireAuth, transactionValidate], createTransaction)
router.post('/transaction/list', [requireAuth, filterValidate], listTransactions)
router.get('/transaction/:transaction', [requireAuth, transactionAuth], findTransaction);
router.put('/transaction/:transaction', [requireAuth, transactionAuth, transactionValidate], updateTransaction);
router.delete('/transaction/:transaction', [requireAuth, transactionAuth], deleteTransaction);

module.exports = (app) => {
  app.use('/api', router);

  app.use((req, res, next) => {
    const error = new Error('Not found');
    error.status = 404;
    next(error);
  });

  app.use((error, req, res, next) => {
    res.status(error.status || 500).json({
      message: error.message
    });
  });
};
