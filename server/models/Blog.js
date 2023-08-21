const mongoose = require("mongoose")
const Schema = mongoose.Schema

const blogSchema = new Schema({
    title: {
        type: String,
        required: true
    },
    likeCount: {
        type: Number,
        required: false
    },

    dislikeCount: {
        type: Number,
        required: false
    },

    content: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        required: true,
        default: Date.now
    },
    description: {
        type:String,
        required:true
    },
    authorName: {
        type: String,
        required: true
    },
    authorEmail: {
        type: String,
        required: true
    } 
})

module.exports = mongoose.model('Blog',blogSchema)