const Restaurant = require('../models/Restaurant');


module.exports = {
    addRestaurant: async (req, res) => {
        const {
            title, time, imageUrl, isAvailable, owner, code, logoUrl, coords
        } = req.body;


        if (!title || !time || !imageUrl || !owner || !code || !logoUrl || !coords && isAvailable !== false && isAvailable !== true) {

            return res.status(400).json({ status: false, message: "All fields are required!" })
        }

        try {
            const newRestaurant = new Restaurant(req.body)
            await newRestaurant.save()
            res.status(201).json({
                status: true, message: 'Restaurant created successfully'
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }

    },

    getRestaurantById: async (req, res) => {
        const { id } = req.params
        try {
            const restaurant = await Restaurant.findById(id);
            res.status(200).json({
                status: true, data: restaurant, message: 'Get restaurant by id is successful!'
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }

    },

    getRestaurantsByOwner: async (req, res) => {
        const { owner } = req.params
        try {
            // const restaurant = await Restaurant.findBy(owner);
            const restaurant = await Restaurant.aggregate([
                { $match: { owner: owner, isAvailable: true } }, { $project: { __v: 0 } }]
            );


            res.status(200).json({
                status: true, data: restaurant, message: 'Get restaurant by owner is successful!'
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }

    },

    getAllRestaurants: async (req, res) => {
        try {
            const restaurants = await Restaurant.find();
            res.status(200).json({
                status: true, data: restaurants, message: 'Get all restaurants  is successful!'
            })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }
    },

    getRandomRestaurants: async (req, res) => {
        const { code } = req.params

        try {
            let randomRestaurant = [];

            if (code) {
                randomRestaurant = await Restaurant.aggregate([
                    { $match: { code: code, isAvailable: true } },
                    { $sample: { size: 5 } },
                    { $project: { __v: 0 } }
                ])
            }

            if (randomRestaurant.length === 0) {
                randomRestaurant = await Restaurant.aggregate([
                    { $match: { isAvailable: true } },
                    { $sample: { size: 5 } },
                    { $project: { __v: 0 } }
                ])
            }

            res.status(200).json({ status: true, message: "Getting random restaurant is successful.", data: randomRestaurant })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }

    },

    getAllNearbyRestaurants: async (req, res) => {
        const code = req.params.code

        try {
            let allNearbyRestaurants = [];

            if (code) {
                allNearbyRestaurants = await Restaurant.aggregate([
                    { $match: { code: code, isAvailable: true } },
                    { $project: { __v: 0 } }
                ])
            }

            if (allNearbyRestaurants.length === 0) {
                allNearbyRestaurants = await Restaurant.aggregate([
                    { $match: { code: code, isAvailable: true } },
                    { $project: { __v: 0 } }
                ])
            }

            res.status(200).json({ status: true, message: "Getting nearby restaurant is successful.", data: allNearbyRestaurants })
        }
        catch (error) {
            res.status(500).json({
                status: false,
                message: error.message
            })
        }

    },


}

// 1:53 part 2