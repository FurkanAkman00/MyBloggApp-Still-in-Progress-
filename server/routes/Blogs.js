const express = require("express")
const router = express.Router()

const controller = require("../controllers/BlogController")
const checkAuth = require("../middlewares/checkAuth")

router.get("/all",controller.getAllBlogs)

router.get("/userBlogs/:token",checkAuth,controller.getUserBlogs)

// router.get("/likedBlogs/:token",checkAuth,controller.getLikedBlogs)

router.delete("/userBlogDelete/:token",checkAuth,controller.deleteUserBlog)

router.post("/:token",checkAuth,controller.createBlog)

router.put("/likeBlog/:isLiked/:token",checkAuth,controller.likeBlog)

router.get("/isLikedBlog/:token",checkAuth,controller.isLikedBlog)


module.exports = router