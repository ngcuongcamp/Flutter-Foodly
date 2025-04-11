const Address = require("../models/Address");
const User = require("../models/User");


module.exports = {
    addAdress: async (req, res) => {
        const newAddress = new Address({
            userId: req.user.id,
            addressLine1: req.body.addressLine1,
            postalCode: req.body.postalCode,
            default: req.body.default,
            deliveryInstructions: req.body.deliveryInstructions,
            latitude: req.body.latitude,
            longitude: req.body.longitude,
        })
        try {
            if (req.body.default === true) {
                await Address.updateMany(
                    { userId: req.user.id },
                    { default: false }
                )
            }

            await newAddress.save()
            res.status(201).json({ message: "Address added successfully" })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },
    getAllAddress: async (req, res) => {
        try {
            const address = await Address.find({ userId: req.user.id })
            res.status(200).json({
                status: true,
                message: "Address fetched successfully",
                data: address
            })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },

    deleteAddress: async (req, res) => {
        try {
            await Address.findByIdAndDelete(req.params.id)
            res.status(200).json({ status: true, message: "Address deleted successfully" })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },

    setAddressDefault: async (req, res) => {
        const addressId = req.params.id; // lấy ID của địa chỉ cần đặt mặc định 
        const userId = req.user.id; // lấy id của user từ token user

        try {
            // 1. cập nhật tất cả các địa chỉ của user đó và bỏ qua trạng thái default 
            await Address.updateMany({ userId: userId }, { default: false })

            // 2. đặt địa chỉ cần set default thành default true 
            const updateAddress = await Address.findByIdAndUpdate(addressId, { default: true })

            // 3. nếu update thành công => cập nhật luôn field `address` vào trong `User`
            if (updateAddress) {
                await User.findByIdAndUpdate(userId, { address: addressId })
                res.status(200).json({
                    status: true,
                    message: "Address successfully set as default"
                })
            } else {
                res.status(404).json({
                    status: false,
                    message: "Address not found"
                })
            }
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },

    getDefaultAddress: async (req, res) => {
        const userId = req.user.id;

        try {
            const address = await Address.findOne({ userId: userId, default: true })
            res.status(200).json({
                status: true,
                message: "Get default address is successfully!",
                data: address
            })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message
            })
        }
    }

}