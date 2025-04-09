const router = require("express").Router();
const addressController = require('../controllers/addressController')
const { verifyTokenAndAuthorization } = require('../middlewares/verifyToken')


router.post("/", verifyTokenAndAuthorization, addressController.addAdress);
router.get("/default", verifyTokenAndAuthorization, addressController.getDefaultAddress);
router.get("/all", verifyTokenAndAuthorization, addressController.getAllAddress);
router.delete("/:id", verifyTokenAndAuthorization, addressController.deleteAddress);
router.patch("/default/:id", verifyTokenAndAuthorization, addressController.setAddressDefault);


module.exports = router;

