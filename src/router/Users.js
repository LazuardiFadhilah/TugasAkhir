const express = require('express');
const router = express.Router();
const userController = require('../controller/userController.js');



router.get('/',userController.show);
router.get('/:id', userController.showId);
router.post('/register',userController.store);
router.put('/:id', userController.update);

module.exports = router;