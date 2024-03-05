const express = require('express');
const indexRoute = require('./router/index.js');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;


// middleware
app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


app.use('/v1', indexRoute);



app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
