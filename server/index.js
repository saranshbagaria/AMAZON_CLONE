//Crete an api
/// package imports [express], 
const express = require('express');
const morgan = require('morgan');

/// local  
const auth = require('./routes/authentication/auth');
const admin = require('./routes/admin');
const product = require ('./routes/product');
const mongoose = require('./services/database');

/// variables 
const PORT = 4000;
const app = express();

app.use(morgan('common'));
/// middleware
app.use(express.json());
app.use(auth.routes);
app.use(admin.adminRouter);
app.use(product.productRouter);
//connections
mongoose.mongoConnect();

/// listeners
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Listening on port ${PORT}`)
});