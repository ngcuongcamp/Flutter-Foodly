const Order = require('../models/Order')


module.exports = {
    placeOrder: async (req, res) => {
        const newOrder = new Order({
            ...req.body,
            userId: req.user.id
        })
        try {
            await newOrder.save()

            const orderId = newOrder._id
            res.status(200).json({ status: true, message: "Order placed successfully", orderId: orderId })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },
    getUserOrders: async (req, res) => {

        // lấy ra id của user
        const userId = req.user.id;
        // lấy ra trạng thái thanh toán, trạng thái order 
        const { paymentStatus, orderStatus } = req.query;


        // khởi tạo query là một giá trị obj, thuộc tính đầu tiên: userId: userId
        let query = { userId }

        // nếu có truyền vào trạng thái thanh toán thì append vào object
        if (paymentStatus) {
            query.paymentStatus = paymentStatus;
        }
        // nếu có truyền vào trạng thái order thì append vào object
        if (orderStatus) {
            query.orderStatus = orderStatus;
        }


        try {
            // đầu tiên, tìm kiếm bảng order, lọc ra các hàng order phù hợp với query
            const orders = await Order.find(query)
                .populate({
                    // trong OrderScheme, có một thuộc tính `orderItems`, nó gồm một mảng các đối tượng (tập hợp) OrderItemSchema
                    path: 'orderItems.foodId',

                    select: "imageUrl title rating time"
                    // chỉ lấy ra mục imageUrl, title, rating, time
                })

            res.status(200).json({
                status: true,
                data: orders,
                message: "Get user orders successfully"
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    }
}