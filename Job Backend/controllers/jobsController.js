const Job = require("../model/jobModel");
const JobType = require("../model/jobTypeModel");
const ErrorResponse = require("../utils/errorResponse");
const cloudinary = require("cloudinary").v2;

const createJob = async (req, res, next) => {
    const { title, subtitle, description, salary, location, image } = req.body;

    try {
        // Validate required fields
        if (!title || !subtitle, !description || !salary || !location) {
            return next(new ErrorResponse("Please provide all required fields", 400));
        }

        let imageUrl;

        // Handle image upload
        if (typeof image === 'string' && image.startsWith('http')) {
            // If image is a URL
            imageUrl = image;
        } else if (req.files && req.files.image) {
            // If image is a file, upload to Cloudinary
            const uploadedImage = await cloudinary.uploader.upload(req.files.image.path, {
                folder: "jobs",
                crop: "scale"
            });
            imageUrl = uploadedImage.secure_url;
        }

        const job = await Job.create({
            title,
            subtitle,
            description,
            salary,
            location,
            image: imageUrl,
        });

        res.status(201).json({
            success: true,
            message: 'Job Created Successfully',
            job
        });
    } catch (error) {
        console.error("Error creating job:", error);
        return next(new ErrorResponse("Server Error", 500));
    }
};


//Update Job
const updateJob = async (req, res, next) => {
    console.log(req.body)
    try {
        const job = await Job.findByIdAndUpdate(req.params.job_id, req.body, { new: true })
            .populate('jobType', 'jobTypeName')
        res.status(200).json({
            success: true,
            message: 'Job edit success',
            job
        })
    } catch (error) {
        return next(error)
    }
}


//For Single Job 
const singleJob = async (req, res, next) => {
    try {
        const job = await Job.findById(req.params.id)
        res.status(200).json({
            success: true,
            job
        })
    } catch (error) {
        return next(error);
    }
}

const showallJobs = async (req, res, next) => {
    try {
        const showJob = await Job.find()
        res.status(200).json({
            success: true,
            message: 'All jobs Fetched Successfully',
            showJob
        })
    } catch (err) {
        return next(err)
    }
}

//Search Filter
const showJobs = async (req, res) => {
    try {
        const { title } = req.query;
        console.log("Title received:", title); // Log the title

        // Ensure title is provided
        if (!title) {
            return res.status(400).json({ success: false, message: 'Title is required' });
        }

        const jobs = await Job.find({
            title: { $regex: title, $options: 'i' }, // case-insensitive search
        });

        console.log("Jobs fetched:", jobs); // Log the fetched jobs

        res.json({ success: true, message: 'Jobs fetched successfully', jobs });
    } catch (error) {
        console.error("Error fetching jobs:", error); // Log the error
        res.status(500).json({ success: false, message: 'Server Error', error: error.message });
    }
};


// const showJobs = async (req, res, next) => {

//     let query = req.query.keyword ? {
//         title: {
//             $regex: new RegExp(req.query.keyword, 'i')
//         }
//     } : {};

//     // filter jobs by category ids
//     let ids = [];
//     const jobTypeCategory = await JobType.find({}, { _id: 1 });
//     jobTypeCategory.forEach(cat => {
//         ids.push(cat._id);
//     })
//     if (req.query.cat) {
//         query = { ...query, jobType: req.query.cat };
//     }


//     //jobs by location
//     let locations = [];
//     const jobByLocation = await Job.find({}, { location: 1 });
//     jobByLocation.forEach(val => {
//         locations.push(val.location);
//     });
//     let setUniqueLocation = [...new Set(locations)];
//     let location = req.query.location;
//     if (location) {
//         let locationFilter = location !== '' ? location : setUniqueLocation;
//         query = { ...query, location: locationFilter };
//     }


//     //enable pagination
//     const pageSize = 12;
//     const page = Number(req.query.pageNumber) || 1;
//     console.log(query)
//     const count = await Job.find({ ...query }).countDocuments();

//     try {
//         // const jobs = await Job.find({ ...keyword, jobType: categ, location: locationFilter }).sort({ createdAt: -1 }).skip(pageSize * (page - 1)).limit(pageSize)
//         const jobs = await Job.find({ ...query }).sort({ createdAt: -1 }).skip(pageSize * (page - 1)).limit(pageSize)

//         res.status(200).json({
//             success: true,
//             message: 'Search Success',
//             jobs,
//             page,
//             pages: Math.ceil(count / pageSize),
//             count,
//             setUniqueLocation,

//         })
//     } catch (error) {
//         next(error);
//     }
// }

const deleteJob = async (req, res, next) => {
    try {
        const user = await Job.findByIdAndDelete(req.params.id, req.body)
        res.status(200).json({
            success: true,
            message: 'Job Deleted Successfully',
            user,

        })
    } catch (error) {
        return next(error)
    }
}

module.exports = {
    createJob, singleJob, updateJob, showJobs, showallJobs, deleteJob
}