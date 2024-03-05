const { Users } = require('../models');
const bcrypt = require('bcrypt');
const Sequelize = require('sequelize');
const Op = Sequelize.Op;
const {paginate} = require("../utilites/pagination.js");


class UserController {
    async show(req, res) {

        try {
            const limit = req.query.limit ?? 5;
            const fullName = req.query.fullName;
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
}

module.exports = new UserController();