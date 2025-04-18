const { default: mongoose } = require("mongoose");


const OrderItemSchema = new mongoose.Schema({
    foodId: { type: mongoose.Schema.Types.ObjectId, ref: "Food", required: true },
    quantity: { type: Number, default: 1 },
    price: { type: Number, required: true },
    additives: { type: Array, default: [] },
    instructions: { type: String, default: "" }
}, { timestamps: true })

const OrderSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    orderItems: [OrderItemSchema],
    orderTotal: { type: Number, required: true },
    deliveryFee: { type: Number, required: true },
    grandTotal: { type: Number, required: true },
    deliveryAddress: {
        type: mongoose.Schema.Types.ObjectId, ref: 'Address', required: true
    },
    restaurantAddress: { type: String, required: true },
    paymentMethod: { type: String, required: true },
    paymentStatus: { type: String, default: 'Pending', enum: ['Pending', 'Completed', 'Failed'] },
    orderStatus: { type: String, default: 'Pending', enum: ['Placed', 'Preparing', 'Manual', 'Delivered', 'Cancelled', 'Ready', 'Out_for_Delivery'] },
    restaurantId: { type: mongoose.Schema.Types.ObjectId, ref: 'Restaurant', required: true },
    restaurantCoords: [Number],
    recipientCoords: [Number],
    driverId: { type: String, default: '' },
    rating: { type: Number, min: 1, max: 5, default: 3 },
    feedback: { type: String },
    promoCode: { type: String },
    discountAmount: { type: Number },
    notes: { type: String }

}, { timestamps: true })

module.exports = mongoose.model("Order", OrderSchema)