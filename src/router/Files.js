const express = require('express');
const router = express.Router();
const FilesController = require('../controller/fileController.js');
const auth = require('../middleware/auth.js');

router.post('/', [auth()],  FilesController.store);

module.exports = router;