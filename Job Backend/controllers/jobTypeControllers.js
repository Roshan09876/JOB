const JobType = require("../model/jobTypeModel");
const ErrorResponse = require("../utils/errorResponse");

//Create Job Category
const createJobType = async(req, res, next) => {
    console.log(req.body);
    try {
        const jobT = await JobType.create({
            jobTypeName: req.body.jobTypeName,
            user: req.user.id
        });
        res.status(201).json({
            success: true,
            message: 'Job Type Created Successfully',
            jobT
        })
    } catch (error) {
        return next(error)
    }
}

//All jobTypes category
const allJobsType = async(req, res, next) => {
    console.log(req.body);
    try {
        const jobT = await JobType.find();
        res.status(200).json({
            success: true,
            job : jobT,
        })
    } catch (error) {
        return next(error)
    }
}

//Update Job Types
const updateJobType = async (req, res, next) => {
    console.log(req.body)
    try {
        const jobT = await JobType.findByIdAndUpdate(req.params.type_id, req.body, { new: true });
        res.status(200).json({
            success: true,
            jobT
        })
    } catch (error) {
        next(error);
    }
}


//Delete Job Types
const deleteJobType = async (req, res, next) => {
    console.log(req.body)
    try {
        const jobT = await JobType.findByIdAndDelete(req.params.type_id);
        res.status(200).json({
            success: true,
            message: "Job Type Deleted"
        })
    } catch (error) {
        next(new ErrorResponse("Server Error", 500));
    }
}

module.exports = {
    createJobType, allJobsType, updateJobType, deleteJobType
};