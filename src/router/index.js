const express = require('express');
const router = express.Router();
const user = require('./Users');
const auth = require('./Auth');
const category = require('./Category');



router.use('/users', user);
router.use('/auth', auth);
router.use('/category', category);


module.exports = router;