const express = require("express");
const router = express.Router();
const postController = require("../controller/postController");
const auth = require('../middleware/auth.js');
const isCreator = require('../middleware/isCreator.js');

router.post("/",[auth(), isCreator()], postController.store);
router.get("/get-by-slug/:slug", postController.getSlug);
router.get('/:id', postController.getId);
router.get('/', postController.show);   
router.delete('/:id', [auth(), isCreator()], postController.destroy);
router.post('/postCategories', postController.storePostCategories);
router.put('/:id', [auth(), isCreator()], postController.update);  // update a specific blog post by

module.exports = router;