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

    isLikedBlog: async(req,res) => {
        try {
            const user = req.user
            const blog = await Blog.findOne(req.body)

            var isLiked = false

            for(var x = 0; x<user.likedBlogs.length;x++){
                if(user.likedBlogs[x].id == blog.id){
                    isLiked = true
                }
            }
            
            if(isLiked){
                console.log(isLiked)
                res.status(200).send(true)
            } else {
                res.status(200).send(false)
            }
            

        } catch (error) {
            console.log(error)
            res.status(400)
        }
    },
/* 
    getLikedBlogs : async(req,res) =>{
        try {
            const user = req.user
            if(user == false){
                res.sendStatus(401)
            } else {
                res.status(200).send(user.likedBlogs)
            }

        } catch (error) {
            console.error(error)
            res.sendStatus(404)
        }
    }, */

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

    likeBlog: async (req,res) => {
        try {
            const user = req.user
            const blog = await Blog.findOne(req.body.blog)
            
            if(user && blog){
                if(req.params.isLiked == "false"){
                    console.log("liked")
                    user.likedBlogs.push(blog)
                    blog.likeCount = blog.likeCount + 1

                    await user.save()
                    await blog.save()

                    res.sendStatus(200)

                } else{
                    console.log("disliked");
                    var myBlog = await Blog.findOne(blog)
                    console.log(myBlog)
                    // const index = user.likedBlogs.indexOf(myBlog)
                    var index = -1
                    for(var i = 0;i<user.likedBlogs.length;i++){
                        if(myBlog.id == user.likedBlogs[i].id){
                            index = i
                            console.log("a")
                        }
                    }
            
                    if (index >-1){
                        user.likedBlogs.splice(index,1)
                    }

                    myBlog.likeCount = myBlog.likeCount - 1

                    await user.save()
                    await myBlog.save()
                    
                    res.sendStatus(200)
                }
                
            } else {
                res.sendStatus(404)
            }

        } catch (error) {
            res.sendStatus(404)
        }
    }
}