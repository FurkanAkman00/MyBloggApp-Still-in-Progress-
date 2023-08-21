const jwt = require("jsonwebtoken")
const User = require("../models/User")

module.exports = async (req,res,next) => {
    try {
        const userID = await jwt.verify(req.params.token,process.env.TOKEN_KEY)
        const user = await User.findById(userID.user_id)
        .populate('blogs')
        .populate("likedBlogs")
        req.user = user
        next()
    } catch (error) {
        console.error(error)
        req.user = false
        next()
    }
}