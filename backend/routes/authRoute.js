const router = require("express").Router();
const authController = require("../controllers/authController");
const { verifyToken } = require("../middlewares/verifyToken")


router.post("/register", verifyToken, authController.createUser);
router.post("/login", verifyToken, authController.loginUser);


module.exports = router;