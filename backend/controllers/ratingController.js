const mongoose = require('mongoose')
const Rating = require('../models/Rating')
const Restaurant = require('../models/Restaurant')
const Food = require('../models/Food')


module.exports = {
    addRating: async (req, res) => {
        const { userId, ratingType, product, rating } = req.body
        if (!userId || !ratingType || !product || !rating) {
            return res.status(400).json({
                status: false,
                message: 'All fields are required'
            })
        }

        const newRating = new Rating({
            userId, ratingType, product, rating
        })

        try {
            await newRating.save()
            if (ratingType === "Restaurant") {
                // nếu ratingType là "Restaurant" thì tính toán lại điểm đánh giá trung bình cho `Restaurant`
                const restaurants = await Rating.aggregate([
                    {
                        // lọc ra tất cả tài liệu có trường `product` bằng với giá trị được cung cấp 
                        $match: { ratingType: ratingType, product: product }
                    },
                    {
                        // gộp nhóm các tài liệu theo trường id (ở đây là product)
                        // tính toán lại điểm đánh giá trung bình của trường `rating` và lưu lại vào `averageRating`
                        $group: { _id: "$product", averateRating: { $avg: "$rating" } }
                    }
                ]);

                if (restaurants.length > 0) {
                    const averageRating = restaurants[0].averageRating;
                    await Restaurant.findByIdAndUpdate(product, { rating: averageRating }, { new: true },)
                }
            }
            else if (ratingType === "Food") {
                const foods = await Rating.aggregate([
                    { $match: { ratingType: ratingType, product: product } },
                    { $group: { _id: "$product", averateRating: { $avg: "$rating" } } }
                ])
                if (foods.length > 0) {
                    const averageRating = foods[0].averageRating;
                    await Food.findByIdAndUpdate(product, { rating: averageRating }, { new: true },)
                }
            }
            res.status(200).json({
                status: true, message: "Rating updated successfully!"
            })
        }
        catch (error) {
            return res.status(500).json({
                status: false,
                message: error.message || error
            })
        }
    },

    checkUserRating: async (req, res) => {
        const { ratingType } = req.query.ratingType;
        const { product } = req.query.product

        try {
            const existingRating = await Rating.findOne({
                userId: req.user.id,
                product: product,
                ratingType: ratingType
            })

            if (existingRating) {
                req.status(200).json({ status: true, message: "You have already rated this restaurant" })
            }
            else {
                req.status(200).json({ status: false, message: "You has not rated this restaurant" })
            }
        }
        catch (error) {
            res.status(500).json({ status: false, message: error.message })
        }
    }
}