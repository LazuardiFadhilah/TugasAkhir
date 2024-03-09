const express = require('express');
const router = express.Router();
const userController = require('../controller/userController.js');
const auth = require('../middleware/auth.js');
const isAdmin = require('../middleware/isAdmin.js');




router.get('/', [auth()], userController.show);
router.get('/:id', userController.showId);
router.post('/register', [auth(), isAdmin()],userController.store);
router.put('/:id', userController.update);
router.delete('/:id', [auth(), isAdmin()], userController.destroy);

module.exports = router;