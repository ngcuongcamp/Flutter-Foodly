const Cart = require('../models/Cart')


module.exports = {
    addProductToCart: async (req, res) => {
        const userId = req.user.id;
        const { productId, totalPrice, quantity, additives } = req.body;

        let count;

        try {
            // tìm sản phẩm đã có trong bảng Cart, với điều kiện lọc 
            // userId là tài khoản đang đăng nhập, id sản phẩm trùng với id đang thêm
            const existingProduct = await Cart.findOne({ userId: userId, productId: productId })

            count = await Cart.countDocuments({ userId: userId })

            // nếu sản phẩm đã tồn tại 
            if (existingProduct) {
                // cập nhật số lượng + tổng giá 
                existingProduct.quantity += quantity
                existingProduct.totalPrice += totalPrice * quantity

                await existingProduct.save()
                return res.status(201).json({
                    status: true,
                    count: count,
                    message: "Added product to cart"
                })
            }
            // nếu sản phẩm chưa tồn tại
            else {
                const newCartItem = new Cart({
                    userId: userId,
                    productId: productId,
                    totalPrice: totalPrice,
                    quantity: quantity,
                    additives: additives

                })
                await newCartItem.save()

                count = await Cart.countDocuments({ userId: userId })
                return res.status(201).json({
                    status: true,
                    count: count,
                    message: "Added product to cart"
                })
            }
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },
    removeCartItem: async (req, res) => {
        const cartItemId = req.params.id;
        const userId = req.user.id

        try {
            await Cart.findByIdAndDelete({ _id: cartItemId })
            const count = await Cart.countDocuments({ userId: userId })

            res.status(200).json({
                status: true,
                count: count,
                message: "Removed product from cart"
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },
    getCart: async (req, res) => {
        const userId = req.user.id
        try {
            const cart = await Cart.find({ userId: userId })
                .populate({
                    path: 'productId',
                    select: 'imageUrl title restaurant rating ratingCount',
                    populate: {
                        path: 'restaurant',
                        select: 'time coords'
                    }
                })
            res.status(200).json({
                status: true,
                message: "Get cart data is successfully",
                data: cart
            })

        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },
    getCartCount: async (req, res) => {
        const userId = req.user.id

        try {
            const count = await Cart.countDocuments({ userId: userId })
            res.status(200).json({ status: true, count: count })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },
    decrementProductQty: async (req, res) => {
        const userId = req.user.id;
        const id = req.params.id;


        try {
            const count = await Cart.countDocuments({ userId: userId })
            res.status(200).json({ status: true, count: count })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    }
}