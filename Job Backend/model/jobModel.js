const mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;

const jobSchema = new mongoose.Schema({
    title: {
        type: String,
        trim: true,
        required: [true, 'Title is Required'],
        maxlength: 50
    },
    subtitle: {
        type: String,
        trim: true,
        required: [true, 'Title is Required'],
        maxlength: 50
    },
    description: {
        type: String,
        trim: true,
        required: [true, 'Description is Required']
    },
    salary: {
        type: String,
        trim: true,
        required: [true, 'Salary is Required']
    },
    location: {
        type: String
    },
    available: {
        type: Boolean,
        default: true
    },
    image: {
        type: String,
        required: false  // Corrected typo in 'required'
    },
}, { timestamps: true });

const Job = mongoose.model('Job', jobSchema);  // 'Job' model name capitalized
module.exports = Job;
