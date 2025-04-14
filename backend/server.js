const express = require('express');
const mongoose = require('mongoose');
const CategoryRoute = require('./routes/categoryRoute')
const RestaurantRoute = require('./routes/restaurantRoute')
const FoodRoute = require('./routes/foodRoute')
const RatingRoute = require('./routes/ratingRoute')
const AuthRoute = require('./routes/authRoute')
const UserRoute = require('./routes/userRoute')
const AddressRoute = require('./routes/addressRoute')
const CartRoute = require('./routes/cartRoute')
const OrderRoute = require('./routes/orderRoute')
const dotenv = require('dotenv');
const cors = require('cors');
dotenv.config()


const app = express();
app.use(cors());
const port = process.env.PORT || 6013
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


mongoose.connect(process.env.MONGOURL)
    .then(() => {
        console.log('Foodly Database Connected')
    }).catch((error) => {
        console.log('Error: ', error);
    })
// const otp = generateOtp()
// sendEmail()

app.use("/", AuthRoute)

app.use("/api/users", UserRoute)
app.use("/api/category", CategoryRoute)
app.use("/api/restaurant", RestaurantRoute)
app.use("/api/food", FoodRoute)
app.use("/api/rating", RatingRoute)
app.use("/api/address", AddressRoute)
app.use("/api/cart", CartRoute)
app.use("/api/order/", OrderRoute)


// app.listen(port, "0.0.0.0", () => {
//     // console.log(`Server is running on http://localhost:${port}`);
//     console.log(`Server is running on http://0.0.0.0:${port}`);
// });


app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});


