const Blog = require("../models/Blog")
const jwt = require("jsonwebtoken")
const User = require("../models/User")

module.exports = {
    getAllPosts :async(req,res) =>{
        try {
            const blogs = await Blog.find()
            if(blogs){
                res.status(200).send(blogs)
            }
            else{
                res.status(400).send("No blogs founded.")
            }
        } catch (error) {
            console.error(error)
        }
    },

    deleteUserPost : async(req,res) => {
        try {
            const user = await findUser(req.params.token)
            const index = user.blogs.indexOf(req.body)
            
            if (index >-1){
                user.blogs.splice(index,1)
            }

            await user.save()
            
            const value = await Blog.findOneAndDelete(req.body)

            if(value){
                res.status(200).send("Deleted Succesfully.")
            } else{
                res.status(404).send("Blog not found.")
            }
            
        } catch (error) {
            res.status(404)
            console.error(error)
        }
    },

    getUserPosts : async(req,res) =>{
        try {
            const user = await findUser(req.params.token)
            res.status(200).send(user.blogs)

        } catch (error) {
            console.error(error)
            res.status(404)
        }
    },

    createBlogPost : async (req,res) =>{
        try { 
            const user = await findUser(req.body.token,res)

            const blog = await Blog.create({
                title: req.body.title,
                content: req.body.content,
                description: req.body.description,
                author: user.username
            })

            user.blogs.push(blog)
            await user.save()

            console.log("Blog created")
            res.sendStatus(201) 

        } catch (error) {
            console.log(error)
            res.sendStatus(404)
        }
    },
}

async function findUser(userToken,res){
    try {
        const userID = jwt.verify(userToken,process.env.TOKEN_KEY)
        return await User.findById(userID.user_id).populate('blogs') 
    } catch (error) {
        console.error(error)
        res.sendStatus(404)
    }

}