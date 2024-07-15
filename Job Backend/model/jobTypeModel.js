const mongoose = require("mongoose")
const {ObjectId} = mongoose.Schema

const jobTypeSchema = new mongoose.Schema({
    jobTypeName: {
        type: String,
        trim: true,
        required: [true, 'Job Category is Required'],
        maxlength: 50
    },
    user: {                 //linking job Model to user Model
        type: ObjectId,
        ref: 'User',
        required: true
    }
}, { timestamps: true });

const JobType = mongoose.model('jobType', jobTypeSchema);
module.exports = JobType;