const { Users } = require('../models');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const env = require('dotenv').config().parsed;

class AuthController {
    generateToken = async (payload) => {
        const expiresIn = env.JWT_ACCESS_TOKEN_EXPIRES_IN;
        const accessToken = jwt.sign(
            { userId: payload.id, },
            env.JWT_ACCESS_TOKEN_SECRET,
            { expiresIn: env.JWT_ACCESS_TOKEN_EXPIRES_IN }
        );

        const refreshToken = jwt.sign(
            { userId: payload.id },
            env.JWT_REFRESH_TOKEN_SECRET,
            { expiresIn: env.JWT_REFRESH_TOKEN_EXPIRES_IN }
        );

        return { accessToken, refreshToken, expiresIn };
    };

    login = async (req, res) => {
        try {
            const user = await Users.findOne({
                where: {
                    email: req.body.email,
                },
        
            });

            // check if user not found
            if (!user) {
                return res.status(400).json({ message: "USER_NOT_FOUND" });
            }

            // check if password is valid
            const isPasswordValid = bcrypt.compareSync(req.body.password, user.password);

            if (!isPasswordValid) {
                return res.status(400).json({ message: "INVALID_PASSWORD" });
            }

            // generate Token
            const { accessToken, expiresIn, refreshToken } = await this.generateToken(user);


            // parse expiresIn from minute, hour, daily into milisecond
            //    example 15m, 1h, 1d
            const expiresInMilisecond = expiresIn.slice(0, expiresIn.length - 1);
            const expiresInType = expiresIn.slice(expiresIn.length - 1);
            let expiresInInMilisecond = 0;
            if (expiresInType === "m") {
                expiresInInMilisecond = expiresInMilisecond * 60000;
            } else if (expiresInType === "h") {
                expiresInInMilisecond = expiresInMilisecond * 3600000;
            } else if (expiresInType === "d") {
                expiresInInMilisecond = expiresInMilisecond * 86400000;
            }

            console.log(expiresInInMilisecond);

            
            return res.status(200).json({
                code: 200,
                message: "Berhasil Masuk",
                accessToken: accessToken,
                refreshToken: refreshToken,
                expiresIn: expiresInInMilisecond,
                tokenType: "Bearer",
                user: {
                    id: user.id,
                    fullName: user.fullName,
                    email: user.email,
                    role: user.role,
                    status: user.status,
                    avatar: user.avatar,
                    createdAt: user.createdAt,
                    updatedAt: user.updatedAt,
                    deletedAt: user.deletedAt,
                },
            });

        } catch (error) {
            return res.status(400).json({ message: error.message });
        }
    }

    register = async (req, res) => {
        try {
            const { fullName, email, password, role} = req.body;

            // check if email already exist
            const isEmailExist = await Users.findOne({ where: { email: email } });
            if (isEmailExist) {
                return res.status(400).json({ message: "EMAIL_ALREADY_EXIST" });
            }

            // check role sudah sesuai apa belum
            const isRoleValid = role === "Creator" || role === "Super Admin";
            if (!isRoleValid) {
                return res.status(400).json({ message: "Role must be Creator or Super Admin" });
            }

            // // check status valid
            // const isStatusValid = status === "Active" || status === "Suspend";
            // if (!isStatusValid) {
            //     return res.status(400).json({ message: "STATUS_INVALID" });
            // }

            // create user
            const user = await Users.create({
                fullName: fullName,
                email: email,
                password: bcrypt.hashSync(password, 10),
                role: role,
                status: "Active",
                avatar: null,
            });
            return res.json({
                "code": 201,
                "message": `Data berhasil dibuat`,
                "data": user,
            })
        } catch (error) {
            return res.status(400).json({ message: error.message });
        }
    }

    refreshToken = async (req,res)=>{
        const refreshToken = req.body.refreshToken;
        if(!refreshToken){
          res.status(401).json({message:"REFRESH_TOKEN_REQUIRED"});
        }
      
        const verified = jwt.verify(refreshToken,env.JWT_REFRESH_TOKEN_SECRET);
       
        try {
          if(!verified){
            throw { message:"UNAUTHORIZED" };
          }
          const userId=verified.userId;
          const user = await Users.findOne({where:{id:userId}});
          if(!user){
            throw { message:"USER_NOT_FOUND" };
          }
          const { accessToken, refreshToken } = await this.generateToken(user);
          return res.status(200).json({accessToken,refreshToken});
        }catch(e){
          if (e.message == "invalid token") {
            e.message = "INVALID_TOKEN";
          } else if (e.message == "jwt expired") {
            e.message = "TOKEN_EXPIRED";
          }
          res.status(401).json({message:e.message});
        }
      }
}

module.exports = new AuthController();