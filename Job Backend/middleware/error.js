const ErrorResponse = require("../utils/errorResponse");

const errorHandler = (err, req, res, next) => {

    let error = {...err};
    error.message = error.message;

    //Mongoose when casting fails, like trying to convert a string to an ObjectId),

    if(err.name == "CastError"){
        const message = `Resource not Found${err.value}`;
        error = new ErrorResponse(message, 404);
    }

    //Mongoose Duplicate Value Error (unique constraint violation),
    if(err.code == 11000){
        const message = `Duplicate Value Entered`;
        error = new ErrorResponse(message, 404);
    }

    // If the error name is "ValidationError" (typically thrown by Mongoose when document validation fails),
    if(err.name == "ValidationError"){
        const message = Object.values(err.errors).map(val => ' ' + val.message);
        error = new ErrorResponse(message, 404);
    }
    
    res.status(error.codeStatus || 500).json({
        success: false,
        message: error.message || "Server Error"
    })
}

module.exports = errorHandler;