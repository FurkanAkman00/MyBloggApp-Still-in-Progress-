const express = require("express")
const router = express.Router()

const controller = require("../controllers/BlogController")

router.get("/all",controller.getAllPosts)

router.get("/userPost/:token",controller.getUserPosts)

router.delete("/userPostDelete/:token",controller.deleteUserPost)

router.post("/", controller.createBlogPost)


module.exports = router