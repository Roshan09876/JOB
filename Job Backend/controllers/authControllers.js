const User = require("../model/userModel");
const ErrorResponse = require("../utils/errorResponse");
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const randomstring = require('randomstring')
const bcrypt = require('bcrypt')


//Only For Registration
const signup = async (req, res, next) => {

    console.log(req.body)
    const { firstName, lastName, email, password } = req.body;
    if (!firstName || !lastName || !email || !password) {
        return res.status(400).json({
            success: false,
            message: 'Please Enter valid email or password'
        })
    }

    try {
        const userExist = await User.findOne({ email });
        if (userExist) {
            return res.json({
                success: false,
                message: "User Already Exist"
            })
        }
        const user = await User.create(req.body)
        res.status(201).json({
            success: true,
            user,
            message: "User Created Successfully"
        })
    } catch (error) {
        console.log(error)
        next(error);
    }


}

//For Signin
const signin = async (req, res, next) => {
    const { email, password } = req.body;
    console.log(req.body)
    //Validation
    if (!email || !password) {
        return res.json({
            success: false,
            message: 'Please enter all fields'
        })
    }
    try {
        //Checking User Email
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({
                success: false,
                message: 'User Doesnot Exist'
            })
        }
        //Checking User Password
        const isMatched = await user.comparePassword(password);
        if (!isMatched) {
            return res.status(400).json({
                success: false,
                message: 'Please enter correct password'
            })
        }
        //Now Sending Token 
        console.log("Login Successful for User", email)
        sendTokenResponse(user, 200, res);

    } catch (error) {
        console.error('Error in signin route:', error);
        next(error)
    }
}

//Making function for Token 
const sendTokenResponse = async (user, codeStatus, res) => {
    const token = await user.getJwtToken();
    res.status(codeStatus)
        .cookie('token', token, { maxAge: 60 * 60 * 1000, httpOnly: true })
        .json({
            success: true,
            token,
            user,
            role: user.role
        })
}

//Log Out Function
const logout = (req, res, next) => {
    res.clearCookie('token')
    res.status(200).json({
        success: true,
        message: "Logged Out Successfully"
    })
}

//User Profile Function
const userProfile = async (req, res, next) => {
    const user = await User.findById(req.user.id).select('-password');
    res.status(200).json({
        success: true,
        user
    })
}

const getUser = async (req,res,next)=> {

    User.findOne({email: req.body.email})
  
    .then((user)=>{
  
      if(!user) return res.status(400).json({error: 'Student not found'})
  
      res.status(200).json({ success: true, data: user })
  
    }).catch(next)
  
  };

//Forgot password 
const forgotPassword = async (req, res, next) => {
    const { email } = req.body;

    //validation
    if (!email) {
        return res.status(400).json({
            success: false,
            message: 'Please Enter email'
        })
    }
    try {
        const user = await User.findOne({ email });
        if (!user) {
            res.status(400).json({
                success: true,
                message: 'User Donot Exist.'
            })
            return;
        }
        //Creating a token 
        const secret = process.env.JWT_SECRET + user.password
        const token = jwt.sign({
            email: user.email,
            id: user._id
        }, secret, { expiresIn: '10m' })

        //Creating a link
        const link = `http://localhost:5500/api/reset-password/${user._id}/${token}`;
        console.log(link)
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'kumaryubraj733@gmail.com',
                pass: 'vuky oazo xczo jclw'
            }
        })

        var mailOption = {
            from: 'kumaryubraj733@gmail.com',
            to: email,
            subject: 'Password Reset link',
            text: link
        };

        transporter.sendMail(mailOption, function(error, info){
            if(error){
                console.log(error)
            }else{
                console.log('Email Sent' + info.response)
            }
        });

    } catch (error) {
        res.status(400).json({
            success: false,
            message: error.message
        })
    }
}

//Reset Password
const resetPassword = async (req, res) => {
    //Taking id and token from params
    console.log("Hittttttttttttt")
    const { id, token } = req.params;
    console.log(id, token)

    // to check if the id or token is provided 
    const oldUser = await User.findById({ _id: id });
    if (!oldUser) {
        return res.status(400).json({
            success: false,
            message: "User Doesnot Exist"
        })
    }
    // //Verifying token
    const secret = process.env.JWT_SECRET + oldUser.password
    try {
        const verify = jwt.verify(token, secret);
        // if token is verified 
        if (verify) {
            res.render('index', { email: verify.email })
        }
    } catch (error) {
        console.log("hello")
        res.status(500).json({
            message: 'Password link is not verified'
        })
    }

}

//Set New Password
const setNewPassword = async (req, res) => {
    console.log(req.body)
    //Getting id and token from params 
    const { id, token } = req.params
    //password from body
    const { password } = req.body

    //Finding user 
    const oldUser = await User.findById({_id: id})
    if(!oldUser){
        return res.status(400).json({
            success: false,
            message: 'User doesnot exist'
        })
    }
    //Creating a secret 
    const secret = process.env.JWT_SECRET + oldUser.password
    try {
        jwt.verify(token, secret);
        const encryptedPassword = await bcrypt.hash(password, 10)
        await User.updateOne({_id: id}, {$set : {password: encryptedPassword}});
        return res.status(200).json({
            success: true,
            message: 'Password Reset Succcessfully'
        })
    } catch (error) {
        console.log(error)
        res.status(500).json({
            message: 'Password reset failed'
        })
    }
}

// const updateJob = async (req, res, next) => {
//     console.log(req.body)
//     try {
//         const job = await Job.findByIdAndUpdate(req.params.job_id, req.body, { new: true })
//         .populate('jobType', 'jobTypeName')
//         res.status(200).json({
//             success: true,
//             message: 'Job edit success',
//             job
//         })
//     } catch (error) {
//         return next(error)
//     }
// }


const updateUserProfile = async (req, res) => {
    try {
        const editprof = await User.findOneAndUpdate({email: req.body.email}, req.body, {new: true})
        res.status(200).json({
            success: true,
            message: 'User update successfully',
            editprof
        })
    } catch (error) {
        console.log(error);
        return res.status(400).json(error);
    }
}

module.exports = {
    signup, signin, logout, userProfile, forgotPassword, resetPassword, setNewPassword, getUser, updateUserProfile
};