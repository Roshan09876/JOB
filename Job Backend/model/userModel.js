const mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken")

const jobsHistorySchema = new mongoose.Schema({
    title: {
        type: String,
        trim: true,
        maxlength: 50
    },
    description: {
        type: String,
        trim: true,
    },
    salary: {
        type: String,
        trim: true,
    },
    location: {
        type: String,
    },
    interviewData: {
        type: Date,
    },
    applicationStatus: {
        type: String,
        enum: ['Pending', 'Accepted', 'rejected'],
        default: 'Pending'
    },
    image: {
        type: String
    },
    user: {                 //linking job Model to user Model
        type: ObjectId,
        ref: 'User',
        required: true
    }
}, { timestamps: true });

const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true,
    },
    lastName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
    },
    location: {
        type: String,
        required: true,
    },
    phoneNum: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
        minlength: [6, 'Password must have at least 6 character']
    },
    jobsHistory: [jobsHistorySchema],
    skills: {
        type: Array,
        default: false
    },
    role: {
        type: Number,
        default: 0,
    }
}, { timestamps: true });
//Use of timestamp is to create two other fields for date and updated date

//Encrypting Pasword Before Saving 
userSchema.pre('save', async function (next) {
    if (!this.isModified('password')) {
        next();
    }
    this.password = await bcrypt.hash(this.password, 10)
})

//Comparing Password 
userSchema.methods.comparePassword = async function (enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
}

//Return JWT Token 
userSchema.methods.getJwtToken = function () {
    return jwt.sign({ id: this.id, 
        firstName: this.firstName, 
        lastName: this.lastName, 
        email: this.email,
        skills: this.skills,
        jobsHistory: this.jobsHistory,
        role: this.role
     }, process.env.JWT_SECRET, {
        //Token Will Expire in One Hour
        expiresIn: 3600
    })
}

const User = mongoose.model("user", userSchema);

module.exports = User;