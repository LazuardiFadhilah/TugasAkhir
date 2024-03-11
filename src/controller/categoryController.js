const {Category} = require('../models');
const sequelize = require('sequelize');

class CatogeryController{
 async store(req,res){
        try {
            const {title} = req.body;
            if(!title){ return res.status(400).json({message:"Title is required"})};
            const category = await Category.create({title});
            return res.json({
                "code": 201,
                "message": "Data berhasil dibuat",
                "data": category,
            });
        } catch (error) {
            return res.status(400).json({message:error.message});
        }
    
 }
}

module.exports = new CatogeryController();