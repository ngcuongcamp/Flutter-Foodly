const User = require('../models/User')


module.exports = {
    getUser: async (req, res) => {
        try {
            const user = await User.findById(req.params.id)
            const {
                password, __v, createAt, ...userData
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