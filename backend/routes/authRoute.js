const router = require("express").Router();
const authController = require("../controllers/authController");
const { verifyToken } = require("../middlewares/verifyToken")


// router.post("/register", verifyToken, authController.createUser);
// router.post("/login", verifyToken, authController.loginUser);

router.post("/register", authController.createUser);
router.post("/login", authController.loginUser);



module.exports = router;