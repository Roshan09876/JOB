const Bookmark = require("../model/bookmarkModel")
const Job = require("../model/jobModel")



// const createBookmark = async (req, res) => {
//     const newBook = new Bookmark(req.body);

//     try {
//         await newBook.save();
//         res.status('Bookmark created successfully')
//     } catch (error) {
//         res.status(500).json(error)
//     }
// }

const createBookmark = async (req, res) => {
    try {
        const newBookmark = new Bookmark({
            job: req.body.jobId,
            userId: req.body.userId
        });

        await newBookmark.save();
        return res.json({ success: true, message: 'Bookmark created successfully' });
    } catch (error) {
        return res.status(400).json({ success: false, error: error.message });
    }
}

const deleteBookmark = async (req, res) => {
    try {
        await Bookmark.findByIdAndDelete(req.params.id);
        res.status(200).json({
            success: true,
            message: 'Bookmark Successfully Deleted'
        })
    } catch (error) {
        res.status(500).json(error)
    }
}

const getBookmark = async (req, res) => {
    try {
        const bookmark = await Bookmark.find({userId: req.params.userId});
        res.status(200).json(bookmark)
    } catch (error) {
        res.status(500).json(error)
    }
}

module.exports = {
    createBookmark, deleteBookmark, getBookmark
}



// const createBookmark = async (req, res) => {
    
//     const jobId = req.body.job

//     try {
//         const job = await Job.findById(jobId);
//         if(!job){
//             return res.status(400).json({
//                 error: "Job not found"
//             })
//         }
//         const newBook = new Bookmark({
//             job: job, 
//             userId: req.User.id
//         })

//         const savedBookmark = await newBook.save()
//         const{__v, updatedAt, ...newBookmarkInfo} = savedBookmark._doc
//         res.status(200).json({
//             success: true,
//             message: 'Bookmark Successfully Created',
//             // bookmark: newBookmarkInfo 
//         })
//     } catch (error) {
//         res.status(500).json(error)
//     }
// }