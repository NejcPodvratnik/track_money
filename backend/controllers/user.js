const User = require('../models/user');
const jwtDecode = require('jwt-decode');
const { validate } = require('deep-email-validator');
const { body, validationResult } = require('express-validator');

const { createToken, hashPassword, verifyPassword } = require('../utils/authentication');

exports.signup = async (req, res) => {

  const result = validationResult(req);
  if (!result.isEmpty()) {
    const errors = result.array({ onlyFirstError: true });
    return res.status(422).json({ message: errors[0].param + ' ' + errors[0].msg });
  }

  try {
    const { name, surname, email } = req.body;
    const { valid, reason, validators } = await validate(email);
    if (!valid) return res.status(422).json({ message: `email is not valid (${reason})` });
    const hashedPassword = await hashPassword(req.body.password);

    const userData = {
      email: email.toLowerCase(),
      name: name,
      surname: surname,
      password: hashedPassword,
    };


    const existingEmail = await User.findOne({
      email: userData.email.toLowerCase()
    }).exec();

    if (existingEmail) {
      return res.status(422).json({
        message: 'Email already exists.'
      });
    }

    const newUser = new User(userData);
    const savedUser = await newUser.save();

    if (savedUser) {
      const token = createToken(savedUser);
      const decodedToken = jwtDecode(token);
      const expiresAt = decodedToken.exp;

      const { email, name, surname, balance, id } = savedUser;
      const userInfo = {
        email,
        name,
        surname,
        balance,
        id,
      };

      return res.status(201).json({
        message: 'User created!',
        token,
        userInfo,
        expiresAt
      });
    } else {
      return res.status(400).json({
        message: 'There was a problem creating your account.'
      });
    }
  } catch (error) {
    return res.status(400).json({
      message: 'There was a problem creating your account.'
    });
  }
};

exports.authenticate = async (req, res) => {
  const result = validationResult(req);
  if (!result.isEmpty()) {
    const errors = result.array({ onlyFirstError: true });
    return res.status(422).json({ message: errors[0].param + ' ' + errors[0].msg });
  }

  try {
    const { email, password } = req.body;
    const user = await User.findOne({
      email: email
    });

    if (!user) {
      return res.status(403).json({
        message: 'Wrong email or password.'
      });
    }

    const passwordValid = await verifyPassword(password, user.password);

    if (passwordValid) {
      const token = createToken(user);
      const decodedToken = jwtDecode(token);
      const expiresAt = decodedToken.exp;
      const { email, name, surname, balance, id } = user;
      const userInfo = { email, name, surname, balance , id };

      res.json({
        message: 'Authentication successful!',
        token,
        userInfo,
        expiresAt
      });
    } else {
      res.status(403).json({
        message: 'Wrong email or password.'
      });
    }
  } catch (error) {
    return res.status(400).json({
      message: 'Something went wrong.'
    });
  }
};

exports.find = async (req, res, next) => {
  try {
    const users = await User.findById(req.params.id);
    res.json(users);
  } catch (error) {
    next(error);
  }
};

exports.validateSignUp = [

  body('email')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')
    
    .isEmail()
    .withMessage('is in wrong format'),

  body('name')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isLength({ max: 16 })
    .withMessage('must be at most 16 characters long')

    .matches(/^[a-zA-Z0-9_-]+$/)
    .withMessage('contains invalid characters'),

    body('surname')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isLength({ max: 16 })
    .withMessage('must be at most 16 characters long')

    .matches(/^[a-zA-Z0-9_-]+$/)
    .withMessage('contains invalid characters'),

  body('password')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isLength({ min: 6 })
    .withMessage('must be at least 6 characters long')

    .isLength({ max: 50 })
    .withMessage('must be at most 50 characters long')
];

exports.validateAuthenticate = [

  body('email')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')
    
    .isEmail()
    .withMessage('is in wrong format'),

  body('password')
    .exists()
    .trim()
    .withMessage('is required')

    .notEmpty()
    .withMessage('cannot be blank')

    .isLength({ min: 6 })
    .withMessage('must be at least 6 characters long')

    .isLength({ max: 50 })
    .withMessage('must be at most 50 characters long')
];
