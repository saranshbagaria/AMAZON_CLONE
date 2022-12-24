

const { json } = require('express');
const ProductDB = require('../moongo.model/admin.moongo');

async function addProduct(productData){
    const {name,description,quantity,images,category,price} = productData;
    let product = new ProductDB(
        {   name:name,
            description:description,
            quantity:quantity,
            images:images,  
            price:price,
            category:category,
        }
    );

    product = await product.save();
    return product;
}

async function deleteProduct(productID){
    let product =  await ProductDB.findByIdAndDelete(productID);
    
    return product;
}



module.exports = {
    addProduct,
    deleteProduct
};
