const User = require('../models/User')
const CryptoJS = require('crypto-js')


module.exports = {
    getUserById: async (req, res) => {
        try {
            const user = await User.findById(req.params.id)
            const {
                password, __v, createdAt, updatedAt, ...userData
            } = user._doc

            res.status(200).json({
                status: true,
                userData
            })
        }

        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },

    getAllUsers: async (req, res) => {
        try {
            const users = await User.find()

            res.status(200).json({
                status: true,
                data: users,
                message: "Get all users successfully"
            })
        }

        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },

    addUser: async (req, res) => {
        try {

            // validate email 
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            if (!emailRegex.test(req.body.email)) {
                return res.status(400).json({ status: false, message: "Invalid email" });
            }

            // validate password (ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt)
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordRegex.test(req.body.password)) {
                return res.status(400).json({
                    status: false,
                    message: 'Password must be at least 8 characters long, include uppercase, lowercase, number, and special character'
                });
            }


            // check email exits 
            const emailExits = await User.findOne({ email: req.body.email })
            if (emailExits) {
                return res.status(400).json({
                    status: false,
                    message: 'Email already exists'
                })
            }


            // password 

            // create new user 
            const newUser = new User({
                username: req.body.username,
                email: req.body.email,
                userType: req.body.userType || "Client",
                otp: req.body.otp || "none",
                password: CryptoJS.AES.encrypt(req.body.password, process.env.SECRET).toString(),
                phone: req.body.phone || "0123456789",
                verification: req.body.verification || false,
                phoneVerification: req.body.phoneVerification || false,

            })

            // save user
            newUser.save()

            res.status(201).json({
                status: true,
                message: 'User added successfully',
                userData: {
                    id: newUser._id,
                    username: newUser.username,
                    email: newUser.email,
                    userType: newUser.userType
                }
            });

        }

        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },
    deleteUser: async (req, res) => {
        try {
            await User.findByIdAndDelete(req.params.id)
            res.status(200).json({ status: true, message: "User successfully deleted" })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },
    verifyAccount: async (req, res) => {
        const userOtp = req.params.otp;

        try {
            const user = await User.findById(req.user.id)

            if (!user) {
                return res.status(400).json({
                    status: false,
                    message: 'User not found'
                })
            }
            if (userOtp === user.otp) {
                user.verification = true;
                user.otp = "none";
                await user.save()

                const { password, __v, otp, createAt, ...others } = user._doc
                return res.status(200).json({
                    status: true,
                    message: 'Account verified successfully',
                    userData: others
                })
            }
            else {
                return res.status(400).json({
                    status: false,
                    message: 'OTP verification failed'
                })
            }
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },


    verifyPhone: async (req, res) => {
        const phone = req.params.phone;

        try {
            const user = await User.findById(req.user.id)

            if (!user) {
                return res.status(400).json({
                    status: false,
                    message: 'User not found'
                })
            }
            user.phoneVerification = true;
            user.phone = phone;
            await user.save()

            const { password, __v, otp, createAt, ...others } = user._doc
            return res.status(200).json({
                status: true,
                message: 'Account verified successfully',
                userData: others
            })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    }
}