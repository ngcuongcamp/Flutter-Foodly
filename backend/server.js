const express = require('express');
const mongoose = require('mongoose');
const CategoryRoute = require('./routes/categoryRoute')
const RestaurantRoute = require('./routes/restaurantRoute')
const FoodRoute = require('./routes/foodRoute')
const dotenv = require('dotenv');

const app = express();
dotenv.config()
const port = process.env.PORT || 6013

mongoose.connect(process.env.MONGOURL)
    .then(() => {
        console.log('Foodly Database Connected')
    }).catch((error) => {
        console.log('Error: ', error);
    })


app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use("/api/category", CategoryRoute)
app.use("/api/restaurant", RestaurantRoute)
app.use("/api/food", FoodRoute)



app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});


