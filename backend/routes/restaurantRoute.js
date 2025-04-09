const router = require('express').Router();
const restaurantController = require('../controllers/restaurantController')
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken")

router.post("/", verifyTokenAndAuthorization, restaurantController.addRestaurant)
router.get("/getAll/", restaurantController.getAllRestaurants)
router.get("/all/:code", restaurantController.getAllNearbyRestaurants)
router.get("/random/:code", restaurantController.getRandomRestaurants)
router.get("/byId/:id", restaurantController.getRestaurantById)
router.get("/byOwner/:owner", restaurantController.getRestaurantsByOwner)


module.exports = router;