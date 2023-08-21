const User = require("../models/User")
const jwt = require("jsonwebtoken")

module.exports = {

    loginPost :async (req,res) =>{
        try {
            const user  = await User.findOne({email: req.body.email,password: req.body.password})
            .populate("blogs")
            .populate("likedBlogs")
           
            if(user){
                const token = createToken(user)
                console.log("Logged in")
                res.status(200).json({token: token, user: user})
            } else {
                res.sendStatus(404)
            }
            
        } catch (error) {
            console.log(error)
            res.sendStatus(404)
        }
    },

    registerPost : async (req,res) => {
        try {  
            const oldUser = await User.findOne({ email: req.body.email })

            if(oldUser){
                res.status(409).send("User Already Exists. Please Login")
            }
            else{
                var user = await User.create(req.body)
                
                const token = createToken(user)

                console.log("User Created")

                res.status(201).json({ token: token,user:user});
            }
        } catch (error) {
            res.sendStatus(404)
            console.log(error)
        }
        
    }
}

function createToken(user){
    const token = jwt.sign(
        { user_id: user._id },
        process.env.TOKEN_KEY,
        {
            expiresIn: "2h"
        }
    )
    return token
}