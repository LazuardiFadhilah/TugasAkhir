const express = require('express');
const router = express.Router();
const categoryController = require('../controller/categoryController.js');
const auth = require('../middleware/auth.js');
const isCreator = require('../middleware/isCreator.js');

router.post('/', [auth(), isCreator()], categoryController.store);
router.get('/', categoryController.show);
router.get('/:id', categoryController.showId);
router.put('/:id', [auth(), isCreator()], categoryController.update);
router.delete('/:id', [auth(), isCreator()], categoryController.destroy);

module.exports = router;