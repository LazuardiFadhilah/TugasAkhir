const express = require('express');
const router = express.Router();
const userController = require('../controller/userController');


router.get('/', userController.show);
router.get('/:id', userController.showId);
router.post('/register', userController.store);

module.exports = router;