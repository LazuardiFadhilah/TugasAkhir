const {Users} = require('../models');

const isCreator = () =>{
    return async (req,res,next)=>{
        try {
          const user = await Users.findOne({where: {id: req.user.id}});
            if(user.role === 'Creator'){
               return next();
            }
            throw {code: 403, message: 'Forbidden!'};
        } catch (error) {
            res.status(error.code).json(error);
        }
    }
};

module.exports = isCreator;