const express = require("express")
require('dotenv').config()
const mongoose = require("mongoose")
const app = express()

app.use(express.json())
app.use(express.urlencoded({extended:true}))

// Connect to mongodb
mongoose.connect(process.env.DATABASE_URL, {useNewUrlParser: true, useUnifiedTopology: true})
.then((result) => console.log("Connected to DB"))
.catch((err) => console.log(err))

const userRoute = require("./routes/User")
app.use("/user",userRoute)

const blogRoute = require("./routes/Blogs")
app.use("/blogs",blogRoute)

app.listen(process.env.PORT || 5000,()=>{ })

module.exports = app