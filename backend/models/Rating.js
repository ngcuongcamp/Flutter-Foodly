const { default: mongoose } = require("mongoose");

const RatingSchema = new mongoose.Schema({
    userId: { type: String, required: true },
    ratingType: { type: String, required: true, enum: ['Restaurant', 'Driver', 'Food'] },
    product: { type: String, required: true },
    rating: { type: Number, min: 0, max: 5, default: 0 }
})


module.exports = mongoose.model("Rating", RatingSchema);