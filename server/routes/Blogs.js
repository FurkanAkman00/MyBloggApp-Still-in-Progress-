const express = require("express")
const router = express.Router()

const controller = require("../controllers/BlogController")
const checkAuth = require("../middlewares/checkAuth")

router.get("/all",controller.getAllBlogs)

router.get("/userBlogs",checkAuth,controller.getUserBlogs)

router.delete("/userBlogDelete",checkAuth,controller.deleteUserBlog)

router.post("/createBlog",checkAuth,controller.createBlog)

router.put("/likeBlog/:isLiked",checkAuth,controller.likeBlog)

router.get("/isLikedBlog",checkAuth,controller.isLikedBlog)


module.exports = router