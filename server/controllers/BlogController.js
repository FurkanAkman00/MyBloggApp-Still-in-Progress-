const Blog = require("../models/Blog")
const jwt = require("jsonwebtoken")
const User = require("../models/User")

module.exports = {
    getAllBlogs :async(req,res) =>{
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

    deleteUserBlog : async(req,res) => {
        try {
            const user = req.user
            if(user){
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
            } else {
            res.sendStatus(401)
        }
            
            
        } catch (error) {
            res.status(404)
            console.error(error)
        }
    },

    getUserBlogs : async(req,res) =>{
        try {
            const user = req.user
            if(user == false){
                res.sendStatus(401)
            } else {
                res.status(200).send(user.blogs)
            }
            

        } catch (error) {
            console.error(error)
            res.sendStatus(404)
        }
    },

    createBlog : async (req,res) =>{
        try { 
            const user = req.user

            if(user){
                const blog = await Blog.create({
                    title: req.body.title,
                    content: req.body.content,
                    description: req.body.description,
                    authorName: user.username,
                    authorEmail: user.email,
                    likeCount: 0
                })

                user.blogs.push(blog)
                await user.save()
    
                console.log("Blog created")
                res.sendStatus(201) 
            }
            else{
                res.sendStatus(401)
            }
            
        } catch (error) {
            console.log(error)
            res.sendStatus(404)
        }
    },
}