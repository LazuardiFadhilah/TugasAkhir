const express = require("express");
const router = express.Router();
const authController = require("../controller/authController");


router.post("/", authController.register);
router.post("/login", authController.login);
router.post('/refresh-token', authController.refreshToken);

module.exports = router;