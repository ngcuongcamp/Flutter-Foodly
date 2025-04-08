const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {
    const authHeader = req.headers.authorization;

    if (authHeader) {
        const token = authHeader.split(' ')[1];
        jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
            if (err) {
                return res.status(403).json({
                    status: false,
                    message: 'Token is not valid'
                });
            }
            req.user = user;
            next();
        });
    }

}

const verifyTokenAndAuthorization = (req, res, next) => {

}


const verifyAdmin = (req, res, next) => {

}
const verifyVendor = (req, res, next) => {

}

const verifyDriver = (req, res, next) => {

}


module.exports = {
    verifyToken,
    verifyTokenAndAuthorization,
    verifyAdmin,
    verifyVendor,
    verifyDriver
}