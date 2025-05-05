const { default: mongoose } = require("mongoose");

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    otp: { type: String, required: false, default: "none" },
    fcm: { type: String, required: false, default: "none" },
    password: { type: String, required: true },
    verification: { type: Boolean, default: false },
    phone: { type: String, default: "" },
    phoneVerification: { type: Boolean, default: false },
    address: { type: mongoose.Schema.Types.ObjectId, ref: "Address", required: false },
    userType: { type: String, required: true, default: "Client", enum: ["Client", "Admin", "Vendor", "Driver"] },
    profile: { type: String, default: "https://e1.pngegg.com/pngimages/621/910/png-clipart-food-2-food-thumbnail.png" },
}, { timestamps: true });


module.exports = mongoose.model("User", UserSchema)