const express = require('express');
const router = express.Router();
const user = require('./Users');

router.use('/users', user);

module.exports = router;