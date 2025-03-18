const router = require('express').Router();

const foodController = require('../controllers/foodController')

router.post("/", foodController.addFood)
router.get("/", foodController.getAllFoods)
router.get("/byId/:id", foodController.getFoodById)
router.get('/search/:searchId', foodController.searchFood)
router.get("/restaurant-foods/:restaurantId", foodController.getFoodsByRestaurant)

router.get("/recommendation", foodController.getRandomFood)
router.get("/recommendation/:code", foodController.getFoodsByCategoryAndCode)
router.get("/recommendation/:category/:code", foodController.getRandomFoodsByCategoryAndCode)

module.exports = router;