const express = require("express")
const router = express.Router()

const controller = require("../controllers/BlogController")
const checkAuth = require("../middlewares/checkAuth")

router.get("/all",controller.getAllBlogs)

router.get("/userBlogs/:token",checkAuth,controller.getUserBlogs)

router.delete("/userBlogDelete/:token",checkAuth,controller.deleteUserBlog)

router.post("/:token",checkAuth,controller.createBlog)


module.exports = router