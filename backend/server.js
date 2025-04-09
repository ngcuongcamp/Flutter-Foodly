const express = require('express');
const mongoose = require('mongoose');
const CategoryRoute = require('./routes/categoryRoute')
const RestaurantRoute = require('./routes/restaurantRoute')
const FoodRoute = require('./routes/foodRoute')
const RatingRoute = require('./routes/ratingRoute')
const AuthRoute = require('./routes/authRoute')
const UserRoute = require('./routes/userRoute')
const AddressRoute = require('./routes/addressRoute')
const dotenv = require('dotenv');

dotenv.config()



const app = express();
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




app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});


