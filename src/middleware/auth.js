const jwt = require("jsonwebtoken");

const auth = ()=> {
  
return(req,res,next)=> {
  

    try {
      
        if(!req.headers["authorization"]){
            throw { message:"TOKEN_REQUIRED" };
        }
        const token = req.headers["authorization"].split(" ")[1];
        if(!token){
            throw { message:"TOKEN_WRONG" };
        }
        const verified = jwt.verify(token,process.env.JWT_ACCESS_TOKEN_SECRET);
        if(!verified){
            throw { message:"UNAUTHORIZED" };
        }
       console.log(verified);
        req.user = {id: verified.userId}
        
        next();
    } catch (error) {
        if (error.message == "invalid token") {
            error.message = "INVALID_TOKEN";
          } else if (error.message == "jwt expired") {
            error.message = "TOKEN_EXPIRED";
          }
    
          return res.status(400).json({ message: error.message });
    }
};
};

module.exports = auth;