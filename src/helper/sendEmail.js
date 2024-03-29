const express = require('express');
const nodemailer = require('nodemailer');
const app = express();
const dotenv = require('dotenv').config().parsed;


class SendEmailController{
      
       sendEmail = async (req, res) => {
        const transporter = nodemailer.createTransport({
            host: process.env.SMTP_HOST,
            port: process.env.SMTP_PORT,
            auth: {
              user: process.env.SMTP_USER,
              pass: process.env.SMTP_PASS
            }
          });
        const { to, subject, text } = req.body;
      
        if (!to || !subject || !text) {
          return res.status(400).send('Missing required fields: to, subject, or text!');
        }
      
        const mailOptions = {
          from: process.env.SMTP_USER,
          to,
          subject,
          text
        };
      
        transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
            return res.status(500).send('Error while sending email!');
          }
          res.send(`Email sent: ${info.response}`);
        });
      };     
}

module.exports = new SendEmailController();