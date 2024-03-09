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
            const { accessToken, expiresIn } = await this.generateToken(user);


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
            const { fullName, email, password, role, status, avatar } = req.body;

            // check if email already exist
            const isEmailExist = await User.findOne({ where: { email: email } });
            if (isEmailExist) {
                return res.status(400).json({ message: "EMAIL_ALREADY_EXIST" });
            }

            // check role sudah sesuai apa belum
            const isRoleValid = role === "Creator" || role === "Admin";
            if (!isRoleValid) {
                return res.status(400).json({ message: "ROLE_INVALID" });
            }

            // check status valid
            const isStatusValid = status === "Active" || status === "Suspend";
            if (!isStatusValid) {
                return res.status(400).json({ message: "STATUS_INVALID" });
            }

            // create user
            const user = await User.create({
                fullName: fullName,
                email: email,
                password: bcrypt.hashSync(password, 10),
                role: role,
                status: status,
                avatar,

            });
        } catch (error) {
            return res.status(400).json({ message: error.message });
        }
    }
}

module.exports = new AuthController();