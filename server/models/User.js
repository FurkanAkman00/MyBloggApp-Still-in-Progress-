const mongoose = require("mongoose")
const Blog = require("./Blog")
const Schema = mongoose.Schema
const bcrypt = require("bcrypt")


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
    }],

    likedBlogs: [{
        type: Schema.Types.ObjectId,
        ref: "Blog"
    }]

})

userSchema.pre("save",async function(next){ // Hash middleware
    try {
        const user = this
        if(!user.isModified("password")){
            next()
        } else {
            const salt = await bcrypt.genSalt(10)
            const hashedPassword = await bcrypt.hash(user.password,salt)
            this.password = hashedPassword
            next()
        }
    } catch (error) {
        next(error)
    }
})

module.exports = mongoose.model('User',userSchema)