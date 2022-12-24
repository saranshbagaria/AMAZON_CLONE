const webToken = require('jsonwebtoken');
const UserDb = require('../model/moongo.model/auth.moongo');

const adminMiddleware = async (req,res,next) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg: "No auth token ,Access Denied"});
        }
        const verified = webToken.verify(token,"passwordKey");

        if(!verified)
            return res.status(401).json({msg: "Token Verification failed, Access Denied "});

        //check if user is admin
        const user  = await UserDb.findById(verified.id);
        
        if(user.type == 'user' || user.type == 'seller'){
            return res.status(401).json({msg: "You are not an admin"});
        }
        
        req.user = verified.id;
        req.token = token;
        req.
        next();
    }catch(e){
        res.status(500).json({
            error: e.message,

        });
    }
}

module.exports = {
    adminMiddleware
}