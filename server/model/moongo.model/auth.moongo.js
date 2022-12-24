const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    user_name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email address'
        }

    },
    password: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value) => {
                return value.length > 6;
            }
        }
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user'
    },
})



module.exports = mongoose.model('User', userSchema);