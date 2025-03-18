const router = require('express').Router();
const restaurantController = require('../controllers/restaurantController')


router.post("/", restaurantController.addRestaurant)
router.get("/getAll/", restaurantController.getAllRestaurants)
router.get("/all/:code", restaurantController.getAllNearbyRestaurants)
router.get("/random/:code", restaurantController.getRandomRestaurants)
router.get("/byId/:id", restaurantController.getRestaurantById)
router.get("/byOwner/:owner", restaurantController.getRestaurantsByOwner)


module.exports = router;