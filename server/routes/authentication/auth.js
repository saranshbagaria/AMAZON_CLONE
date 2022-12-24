/**
 * @author : Saransh Bagaria,
 * @param express : Exporting express as module
 * @param routes : Creating routes for broad range of nodes
 * 
 */
// package import {express}

const express = require('express')

// local package
const userModel = require('../../model/data.model/auth.model')
const {authMiddleware} = require('../../middleware/auth.middleware');
// variables
const routes = express.Router();

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

routes.post('/tokenIsValid', async(req,res) =>{
    try{
        const valid = await userModel.tokenValidator(req.header('x-auth-token'));
        return res.json(valid);
    } catch(e){
        res.status(500).json({error: e.message});
    }
})

routes.get('/',authMiddleware, async (req,res) =>{
    const user = await userModel.provideUserData(req.user);
    res.json({...user._doc,token: req.token});
})
/// exports
module.exports = { routes }