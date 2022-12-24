const webToken = require('jsonwebtoken');

const authMiddleware = (req,res,next) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg: "No auth token ,Access Denied"});
        }
        const verified = webToken.verify(token,"passwordKey");
        if(!verified)
            return res.status(401).json({msg: "Token Verification failed, Access Denied "});
        /// 
        req.user = varified.id;
        req.token = token;
        next();
    }catch(e){
        res.status(500).json({error: e.message});
    }
}

module.exports = {
    authMiddleware
}