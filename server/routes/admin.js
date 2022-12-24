const express =  require('express');

const adminRouter = express.Router(); 

const admin = require('../model/moongo.model/admin.moongo');
const adminMOdel = require('../model/data.model/admin.model');
const { json } = require('express');

adminRouter.post('/admin/add-product', async (req,res) =>{
    try{
        var response = await adminMOdel.addProduct(req.body);
        res.json(response);
    }
    catch(e){
        res.status(500).json({error : e.message});
    }
})

adminRouter.get('/admin/get-products', async (req,res) => {
    try{
        const product = await admin.find();
        res.status(200).json(product);
        
    }catch(e){
        res.status(500).json({error : e.message});
    }
},
)

adminRouter.post('/admin/delete-product', async (req,res) => {
    try{
        const{ _id} = req.body;
        const product = adminMOdel.deleteProduct(_id);
        res.status(200).json(product);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
})



module.exports = {adminRouter};
