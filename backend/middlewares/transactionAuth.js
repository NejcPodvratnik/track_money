const transactionAuth = (req, res, next) => {
  if (req.transaction.owner.equals(req.user.id)) return next();
  res.status(401).end();
};

module.exports = transactionAuth;
