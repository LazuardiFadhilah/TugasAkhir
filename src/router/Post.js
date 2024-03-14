const express = require("express");
const router = express.Router();
const postController = require("../controller/postController");
const auth = require('../middleware/auth.js');
const isCreator = require('../middleware/isCreator.js');

router.post("/",[auth(), isCreator()], postController.store);
router.get("/get-by-slug/:slug", postController.getSlug);
router.get('/:id', postController.getId);
router.delete('/:id', [auth(), isCreator()], postController.destroy);

module.exports = router;