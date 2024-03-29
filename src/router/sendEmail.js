const express = require("express");
const router = express.Router();
const SendEmailController = require( "../helper/sendEmail" );

router.post('/', SendEmailController.sendEmail);

module.exports = router;