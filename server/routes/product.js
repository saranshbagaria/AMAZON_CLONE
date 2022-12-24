const express =  require('express');

const productRouter = express.Router(); 

const{ authMiddleware} = require('../middleware/auth.middleware');

const productDb = require('../model/moongo.model/admin.moongo');


productRouter.get("/api/products", authMiddleware , async (req,res) => {
    try{
        const products = await productDb.find({category: req.query.category});
        res.status(200).json(products);
    }catch(e){
        res.status(500).json({error : e.message});
    }
});

productRouter.get('/api/products/search/:name',authMiddleware, async (req,res) => {
    try{
        
        const products = await productDb.find({
            name : {$regex : req.params.name, $options : "i"},
        });
        res.status(200).json(products);
    }catch(e){
        res.status(500).json({error : e.message});
    }
}
);
//

productRouter.post('/api/rate-product', authMiddleware ,async (req,res) => {
    try{
        const {id,rating} = req.body;
        let product = await productDb.findById(id); 

        for(let i = 0 ; i < product.ratings.length; i++ ) {
            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1);
                break;
            }
        }

        const ratingSchema = {
            userId : req.user,
            rating ,
        }

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    }catch(e){
        res.status(500).json({error : e.message});
    }
});

module.exports = {productRouter};
