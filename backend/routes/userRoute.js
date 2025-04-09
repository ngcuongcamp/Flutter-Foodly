const router = require("express").Router();
const userController = require("../controllers/userController")
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken")

router.get('/', verifyTokenAndAuthorization, userController.getAllUsers)
router.get('/:id', verifyTokenAndAuthorization, userController.getUserById)

router.post("/", verifyTokenAndAuthorization, userController.addUser)
router.delete('/', verifyTokenAndAuthorization, userController.deleteUser)
router.get("/verify/:otp", verifyTokenAndAuthorization, userController.verifyAccount)
router.get("/verify_phone/:phone", verifyTokenAndAuthorization, userController.verifyAccount)



module.exports = router;