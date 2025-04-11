const router = require("express").Router();
const orderController = require('../controllers/orderController')
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken")



router.get("/", verifyTokenAndAuthorization, orderController.getUserOrders)
router.post('/', verifyTokenAndAuthorization, orderController.placeOrder)



module.exports = router;
