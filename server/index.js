//Crete an api
/// package imports [express], 
const express = require('express');


/// local imports
const auth = require('./routes/authentication/auth');
const mongoose = require('./services/database');

/// variables 
const PORT = 4000;
const app = express();

/// middleware
app.use(express.json());
app.use(auth.routes);

//connections
mongoose.mongoConnect();

/// listeners
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Listening on port ${PORT}`)
});