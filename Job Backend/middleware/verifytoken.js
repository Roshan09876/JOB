const ErrorResponse = require ("../utils/errorResponse");
const jwt = require ("jsonwebtoken")
const User = require ("../model/userModel")

const verifytoken = (req, res, next) => {
    const authheader = req.header.token
    if(authheader){
        const token = authheader.spilt("")[1];

        jwt.verify(token, process.env.JWT_SECRET, async (err, User) => {
            if(err){
                res.status(403).json('Invalid token')
                req.user = User;
                console.log(User)
                next()
            }
        })
    }else{
        return res.status(401).json({
            message: 'You are not authinticated'
        })
    }
}

const verifyAndAuthorization = (req, res, next) => {
    verifytoken(req, res, () => {
        if(req.User.id == req.params.id){
            next()
        }else{
            res.status(403).json('You are restricted to perform this operation')
        }
    })
}

module.exports = {
     verifytoken, verifyAndAuthorization
}