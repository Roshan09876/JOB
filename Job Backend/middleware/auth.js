const ErrorResponse = require ("../utils/errorResponse");
const jwt = require ("jsonwebtoken")
const User = require ("../model/userModel")

//Check if user is authienticated or not 
const isAuthenticated = async (req, res, next) => {
    //We have to make sure token exist 
    const {token} = req.cookies;
    if(!token){
        return res.json({
            success: false,
            message: 'Not Authorised to access this route'
        });
    }
    try {
        //We have to verify token 
        const decoded = jwt.verify(token, process.env.JWT_SECRET)
        req.user = await User.findById(decoded.id);
        next();
        
    } catch (error) {
        return next(new ErrorResponse('Not Authorise to access this route', 401));
    }
}

//MiddleWare for admin 
const isAdmin = (req, res, next) => {
    if(req.user.role === 0){
        return res.json({
            success: false,
            message: 'Access Denied, You must be an Admin'
        })
    }
    next();
}

module.exports = {
    isAuthenticated, isAdmin
}