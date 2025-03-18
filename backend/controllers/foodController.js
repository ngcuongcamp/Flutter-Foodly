const Food = require('../models/Food')
const mongoose = require('mongoose')

module.exports = {
    addFood: async (req, res) => {
        const { title, time, foodTags, category, code, description, price, imageUrl, isAvailable } = req.body

        if (!title || !foodTags || !foodTags || !time || !category || !code || !description || !price || !imageUrl && isAvailable !== true && isAvailable !== false) {
            return res.status(400).json({
                status: false,
                message: 'All fields are required'
            })
        }

        try {
            const newFood = new Food(req.body)
            await newFood.save()
            res.status(201).json({
                status: true, message: 'Category created sucessful', data: newFood
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },
    getAllFoods: async (req, res) => {
        try {
            const foods = await Food.find()

            res.status(201).json({
                status: true, message: 'Get all food data!', data: foods
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },

    getFoodById: async (req, res) => {
        const { id } = req.params
        try {
            const foods = await Food.findById(id)

            res.status(201).json({
                status: true, message: 'Get food data info is sucessful!', data: foods
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },

    getRandomFood: async (req, res) => {
        const { code } = req.params

        try {
            let randomFood = []
            if (code) {
                randomFood = Food.aggregate([
                    { $match: { code: code, isAvailable: true } },
                    { $sample: { size: 5 } },
                    { $project: { __v: 0 } }
                ])
            }

            if (randomFood.length === 0) {
                randomFood = Food.aggregate([
                    { $match: { isAvailable: true } },
                    { $sample: { size: 5 } },
                    { $project: { __v: 0 } }
                ])
            }

            res.status(200).json({ status: true, message: "Getting random food is successful.", data: randomFood })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error || error.message
            })
        }
    },

    getFoodsByRestaurant: async (req, res) => {
        const restaurantId = new mongoose.Types.ObjectId(req.params.restaurantId)
        try {
            // const food = await Food.find({ restaurant: restaurantId })
            const food = await Food.aggregate([
                { $match: { restaurant: restaurantId, isAvailable: true } },
                { $project: { __v: 0 } }
            ]
            );

            res.status(200).json({
                status: true, data: food, message: 'Get food by restaurant is successful!'
            })
        }
        catch (error) {
            res.status(500).json({ status: false, message: error.message || error })
        }
    },
    getFoodsByCategoryAndCode: async (req, res) => {
        const { category, code } = req.params

        try {
            const foods = await Food.aggregate([
                { $match: { category: category, code: code, isAvailable: true } }, { $project: { __v: 0 } }
            ])
            if (foods.length === 0) {
                return res.status(200).json({
                    status: true,
                    message: "No food found with this category and code.",
                    data: []
                })
            }
            res.status(200).json({
                status: true,
                message: "Get food by category and code is successful.",
                data: foods
            })
        }
        catch (error) {
            res.status(500).json({ status: false, message: error.message || error })
        }
    },
    searchFood: async (req, res) => {
        const searchId = req.params.searchId
        try {
            const food = await Food.find({
                title: {
                    $regex: searchId,
                    $options: 'i'
                }
            })

            res.status(200).json({
                status: true, data: food, message: 'Search food is successful!'
            })
        }
        catch (error) {
            res.status(500).json({ status: false, message: error.message || error })
        }
    },
    getRandomFoodsByCategoryAndCode: async (req, res) => {
        const { category, code } = req.params

        try {
            let foods = []

            foods = await Food.aggregate([
                { $match: { category: category, code: code, isAvailable: true } },
                { $sample: { size: 10 } }
            ])

            if (!foods || foods.length === 0) {
                foods = await Food.aggregate([
                    {
                        $match: { code: code, isAvailable: true },
                    },
                    { $sample: { size: 10 } }
                ])
            } else {
                foods = await Food.aggregate([
                    {
                        $match: { isAvailable: true },
                    },
                    { $sample: { size: 10 } }
                ])
            }
            res.status(200).json({
                status: true, data: foods, message: 'Get random food by category and code is successful!'
            })

        }
        catch (error) {
            res.status(500).json({ status: false, message: error.message || error })
        }
    }
}