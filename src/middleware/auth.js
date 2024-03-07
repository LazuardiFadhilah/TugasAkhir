const { Users } = require('../models');

async function adminOnly(req,res,next){
    const auth = req.headers.authorization;
        try {
            if(!req.headers.authorization){
                throw { code: 401, message: 'Super Admin required!'};
            } else if(req.headers.authorization !== 'Super Admin'){
                throw { code: 401, message: 'Invalid Role!'};
            }

         
            next();
        } catch (error) {
           res.status(error.code).json(error);
        }

    
   
}

module.exports = adminOnly;