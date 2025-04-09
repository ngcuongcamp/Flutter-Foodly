const router = require('express').Router();
const foodController = require('../controllers/foodController')
const { verifyVendor } = require("../middlewares/verifyToken")




// get all and new insert
router.post("/", verifyVendor, foodController.addFood)
router.get("/", foodController.getAllFoods)
router.put('/:id', foodController.updateFood)
router.delete('/delete/:id', foodController.deleteFood)
router.put('/addTags/:id', foodController.addTagsFood)
router.put('/removeTags/:id', foodController.removeTagsFood)
router.put('/updateTags/:id', foodController.updateTagsFood)



// search by Food Id
router.get("/byId/:id", foodController.getFoodById)
// search by Food title
router.get('/search/:searchTitle', foodController.searchFood)

// get Food by RestaurantId, CategoryId and Code
router.get("/restaurant-foods/:restaurantId", foodController.getFoodsByRestaurant)
router.get("/restaurant-foods/:categoryId/:code", foodController.getFoodsByCategoryAndCode)

// get random
router.get("/recommendation/:code", foodController.getRandomFood)
router.get("/recommendation/:categoryId/:code", foodController.getRandomFoodsByCategoryAndCode)

module.exports = router;