const {Users} = require('../models');

const isAdmin = () =>{
    return async (req,res,next)=>{
        try {
          const user = await Users.findOne({where: {id: req.user.id}});
            if(user.role === 'Super Admin'){
               return next();
            }
            throw {code: 403, message: 'Forbidden!'};
        } catch (error) {
            res.status(error.code).json(error);
        }
    }
};

module.exports = isAdmin;