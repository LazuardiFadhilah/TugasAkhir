const { Users } = require('../models');
const bcrypt = require('bcrypt');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;
const {paginate} = require("../utilites/pagination.js");



class UserController {
    async show(req, res) {
        try {
            const limit = req.query.limit ?? 5;
            const fullName = req.query.fullName ?? "";
            const page = req.query.page ?? 1;

            // console.log(limit);
           

            const user = await Users.findAll(
           paginate(
            {
                where:{fullName: {[Op.like]: "%" + fullName + "%",}},
                attributes: { exclude: ['password'] },
            
            },{
                page: parseInt(page),
                pageSize: parseInt(limit),
            },
           ),
            );



            return res.json({
                "code": 200,
                "message": `${user.length} data sudah diterima`,
                "count": user.length,
                "data": user,
            });
        } catch (error) {
            return res.status(400).json({ message: error.message });
        }
    }

    async showId(req, res){
        try {
            const id = req.params;
            
            const user = await Users.findOne({where:{
                id:id,
            }});
            console.log(user);
            return res.json({
                "code": 200,
                "message": `Data berhasil`,
                "data": user,
            });
        } catch (error) {
            return res.status(404).json({message:'Data Not Found'});
        }
    }

    async store(req, res) {
        try {
            const { fullName, email, newPassword, confirmNewPassword, role, status, avatar } = req.body;
            if (newPassword !== confirmNewPassword) {
                return res.status(400).json({ message: "Password tidak sama" });
            }

            const user = await Users.create({
                
                fullName,
                email,
                password: bcrypt.hashSync(newPassword, 10),
                role,
                status,
                avatar,
                attributes: { include: ['deletedAt'] },
            });
            return res.json({
                "code": 201,
                "message": `Data berhasil dibuat`,
                "data": user,
            });
        } catch (error) {
            return res.status(400).json({message:error.message});
        }
    }

    async update(req,res){
      
        try {
            const id = req.params;
            const {fullName, email, newPassword, confirmNewPassword, role, status, avatar} = req.body;
            console.log({fullName, email, newPassword, confirmNewPassword, role, status, avatar});
            if(newPassword && confirmNewPassword == ""){
            try {
                const user = await Users.findOne({where:{id:id}});
                newPassword = user.newPassword;
                confirmNewPassword = user.confirmNewPassword;
            } catch (error) {
                return res.status(400).json({message:error.message});
            }
           }
           if(newPassword !== confirmNewPassword){
               return res.status(400).json({message:"Password tidak sama"});}
            
            const userData = await Users.update({
                fullName,
                email,
                password: bcrypt.hashSync(newPassword, 10),
                role,
                status,
                avatar,
            },{where:{id:id}});
            const job = await Users.findOne({where:{id:id}});
            return res.json({
                "code": 200,
                "message": `Data berhasil diperbaharui`,
                "data": job,
            });
          
        } catch (error) {
            return res.status(400).json({message:error.message});
        }
    }

    async destroy(req,res){
        try {
            const id = req.params;
            const user = await Users.destroy({where:{id:id}});
            return res.json({
                "code": 200,
                "message": `Data berhasil dihapus`,
                
             
            });
            
        } catch (error) {
            return res.status(400).json({message:error.message});
        }
    }
}

module.exports = new UserController();