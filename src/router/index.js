const express = require('express');
const router = express.Router();
const user = require('./Users');
const auth = require('./Auth');



router.use('/users', user);
router.use('/auth', auth);


module.exports = router;