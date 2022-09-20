/**
 * @author : Saransh Bagaria,
 * @param express : Exporting express as module
 * @param routes : Creating routes for broad range of nodes
 * 
 */
// package import {express}

const express = require('express')

// local package
const userModel = require('../../model/auth.model')

// variables
const routes = express.Router();

//
routes.post('/api/signup', async(req, res) => {
    try {
        const { name, email, password } = req.body;
        const addedUser = await userModel.addUser({
            user_name: name,
            email: email,
            password: password
        });
        console.log(addedUser);
        if (!addedUser) {
            return res.status(400).json({ msg: 'user with same email already exist' })
        }
        return res.json(addedUser);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

routes.post('/api/signin', async(req, res) => {
    try {
        const { email, password } = req.body;
        const validUser = await userModel.validateUser({
            email: email,
            password: password
        })

        if (validUser.statusCode != 200) {
            return res.status(validUser.statusCode).json({ msg: validUser.msg });
        }

        delete validUser['statusCode'];
        return res.status(200).json(validUser);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

/// exports
module.exports = { routes }