const mongoose = require("mongoose")
const Blog = require("./Blog")
const Schema = mongoose.Schema

const userSchema = new Schema({
    username: {
        type: String,
        required: true
    },

    password: {
        type: String,
        required: true
    },

    email: {
        type: String,
        required: true
    },

    blogs: [{
        type: Schema.Types.ObjectId,
        ref: "Blog"
    }]

})

module.exports = mongoose.model('User',userSchema)