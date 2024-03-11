const express = require('express');
const router = express.Router();
const categoryController = require('../controller/categoryController.js');
const auth = require('../middleware/auth.js');
const isCreator = require('../middleware/isCreator.js');

router.post('/', [auth(), isCreator()], categoryController.store);

module.exports = router;