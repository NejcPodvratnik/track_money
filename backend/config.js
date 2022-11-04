module.exports = {
  port: process.env.PORT || 8000,
  db: {
    prod: process.env.DB_URL || 'mongodb://localhost:27017/track_money',
    options: {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useFindAndModify: false,
      useCreateIndex: true
    }
  },
  jwt: {
    secret: process.env.TOKEN_SECRET || 'development_secret',
    expiry: '90d'
  }
};
