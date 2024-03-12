const express = require('express');
const router = express.Router();
const user = require('./Users');
const auth = require('./Auth');
const category = require('./Category');
const post = require('./Post');
const files = require('./Files');



router.use('/users', user);
router.use('/auth', auth);
router.use('/category', category);
router.use('/post', post);
router.use('/file', files);



module.exports = router;