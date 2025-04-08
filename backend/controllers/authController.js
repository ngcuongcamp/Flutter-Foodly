const User = require('../models/User')
const CryptoJS = require('crypto-js')
const jwt = require('jsonwebtoken')
const generateOtp = require('../utils/ot_generator')

module.exports = {
    createUser: async (req, res) => {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
        if (!emailRegex.test(req.body.email)) {
            return res.status(400).json({
                status: false,
                message: 'Email is not valid'
            })
        }

        const minPasswordLength = 8;
        if (length(req.body.password) < minPasswordLength) {
            return res.status(400).json({
                status: false,
                message: `Password must be at least ${minPasswordLength} characters long`
            })
        }

        try {
            const emailExists = await User.findOne({ email: req.body.email });
            if (emailExists) {
                return res.status(400).json({
                    status: false,
                    message: 'Email already exists'
                })
            }

            // GENERATE OTP 
            const newUser = new User({
                username: req.body.username,
                email: req.body.email,
                userType: "Client",
                password: CryptoJS.AES.encrypt(req.body.password, process.env.SECRET).toString(),
                otp: generateOtp()
            })
            // SAVE USER 
            await newUser.save()
            // SEND OTP TO EMAIL
            sendEmail(newUser.email, newUser.otp)

            res.status(201).json({ status: true, message: "User created successfully!" })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },
    loginUser: async (req, res) => {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
        if (!emailRegex.test(req.body.email)) {
            return res.status(400).json({
                status: false,
                message: 'Email is not valid'
            })
        }

        const minPasswordLength = 8;
        if (length(req.body.password) < minPasswordLength) {
            return res.status(400).json({
                status: false,
                message: `Password must be at least ${minPasswordLength} characters long`
            })
        }
        try {
            const user = await User.findOne({ email: req.body.email })
            if (!user) {
                return res.status(400).json({
                    status: false,
                    message: 'Account is not registered'
                })
            }
            const decryptedPassword = CryptoJS.AES.decrypt(user.password, process.env.SECRET).toString(CryptoJS.enc.Utf8)

            if (decryptedPassword !== req.body.password) {
                return res.status(400).json({ status: false, message: 'Password is incorrect' })
            }

            const userToken = jwt.sign({
                id: user._id,
                userType: user.userType,
                email: user.email,
            }, process.env.JWT_SECRET, { expiresIn: '21d' })

            const { password, otp, ...others } = user.doc;

            res.status(200).json({ ...others, userToken });

        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }

    },
}