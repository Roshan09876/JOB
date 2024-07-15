const mongoose = require('mongoose')
const {ObjectId} = mongoose.Schema

const BookMarkSchema = new mongoose.Schema({
    job: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Job'
    },
    userId: {                 
        type: ObjectId,
        required: true
    },
},  
     {timestamps: true})

module.exports = mongoose.model('Bookmark', BookMarkSchema)

