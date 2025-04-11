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
                message: error.message
            })
        }
    },
    updateFood: async (req, res) => {
        const { id } = req.params;
        const { title, time, foodTags, category, code, description, price, imageUrl, isAvailable } = req.body;

        if (!title || !foodTags || !time || !category || !code || !description || !price || !imageUrl || isAvailable === undefined) {
            return res.status(400).json({
                status: false,
                message: 'All fields are required'
            });
        }

        if (isAvailable !== true && isAvailable !== false) {
            return res.status(400).json({
                status: false,
                message: 'isAvailable must be true or false'
            });
        }

        try {
            if (!mongoose.Types.ObjectId.isValid(id)) {
                return res.status(400).json({
                    status: false,
                    message: 'Invalid food ID format!'
                });
            }
            const foodId = new mongoose.Types.ObjectId(id);

            const food = await Food.findById(foodId);
            if (!food) {
                return res.status(404).json({
                    status: false,
                    message: 'Food not found!'
                });
            }

            food.title = title;
            food.time = time;
            food.foodTags = foodTags;
            food.category = category;
            food.code = code;
            food.description = description;
            food.price = price;
            food.imageUrl = imageUrl;
            food.isAvailable = isAvailable;

            await food.save();

            res.status(200).json({
                status: true,
                message: 'Food updated successfully',
                data: food
            });
        } catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },

    deleteFood: async (req, res) => {
        const { id } = req.params
        console.log(id)
        try {
            const food = await Food.findByIdAndDelete(id)

            if (food) {
                res.status(200).json({
                    status: true, message: 'Food deleted successfuly!', data: food
                })
            }
            res.status(404).json({
                status: false, message: 'Not found food info', data: food
            })

        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },

    addTagsFood: async (req, res) => {
        const { id } = req.params
        const { foodTags } = req.body

        try {
            if (!foodTags || !Array.isArray(foodTags)) {
                return res.status(400).json({
                    status: false,
                    message: "foodTags must be an array!"
                })
            }
            const food = await Food.findById(id)
            if (!food) {
                return res.status(404).json({
                    status: false, message: "Food not found!"
                })
            }

            const newFoodTags = [...new Set([...food.foodTags, ...foodTags])]
            food.foodTags = newFoodTags
            await food.save()
            console.log(newFoodTags)
            res.status(200).json({
                status: true, message: 'Food tags updated successfuly!', data: food
            })



        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },
    removeTagsFood: async (req, res) => {
        const { id } = req.params;
        const { foodTags } = req.body;

        try {
            if (!foodTags || !Array.isArray(foodTags)) {
                return res.status(400).json({
                    status: false,
                    message: "foodTags must be an array!"
                });
            }

            const food = await Food.findById(id);
            if (!food) {
                return res.status(404).json({
                    status: false,
                    message: "Food not found!"
                });
            }

            food.foodTags = food.foodTags.filter(tag => !foodTags.includes(tag));
            await food.save();
            res.status(200).json({
                status: true,
                message: 'Food tags removed successfully!',
                data: food
            });

        } catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },
    updateTagsFood: async (req, res) => {
        const { id } = req.params;
        const { foodTags } = req.body;

        try {
            if (!foodTags || !Array.isArray(foodTags)) {
                return res.status(400).json({
                    status: false,
                    message: "foodTags must be an array!"
                });
            }

            if (!mongoose.Types.ObjectId.isValid(id)) {
                return res.status(400).json({
                    status: false,
                    message: "Invalid food ID format!"
                });
            }
            const foodId = new mongoose.Types.ObjectId(id);

            const food = await Food.findById(foodId);
            if (!food) {
                return res.status(404).json({
                    status: false,
                    message: "Food not found!"
                });
            }

            food.foodTags = foodTags;
            await food.save();

            res.status(200).json({
                status: true,
                data: food,
                message: 'Food tags updated successfully!'
            });
        } catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
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
                message: error.message
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
                message: error.message
            })
        }
    },

    getRandomFood: async (req, res) => {

        const { code } = req.params

        try {
            let randomFood = []
            if (code) {
                randomFood = await Food.aggregate([
                    { $match: { code: code, isAvailable: true } },
                    { $sample: { size: 5 } },
                    { $project: { __v: 0 } }
                ])
            }

            if (randomFood.length === 0) {
                randomFood = await Food.aggregate([
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
                message: error.message
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
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },
    getFoodsByCategoryAndCode: async (req, res) => {
        const { categoryId, code } = req.params
        console.log(categoryId, code)

        try {
            const foods = await Food.aggregate([
                { $match: { category: categoryId, code: code, isAvailable: true } }, { $project: { __v: 0 } }
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
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },
    searchFood: async (req, res) => {
        const searchTitle = req.params.searchTitle
        try {
            const food = await Food.find({
                title: {
                    $regex: searchTitle,
                    $options: 'i'
                }
            })

            res.status(200).json({
                status: true, data: food, message: 'Search food is successful!'
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },
    getRandomFoodsByCategoryAndCode: async (req, res) => {
        const { categoryId, code } = req.params

        try {
            let foods = []

            foods = await Food.aggregate([
                { $match: { category: categoryId, code: code, isAvailable: true } },
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
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    }
}