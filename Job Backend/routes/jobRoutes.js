const express = require("express");
const router = require("./jobsTypeRoutes");
const jobControllers = require("../controllers/jobsController")
const auth = require('../middleware/auth')

//Create Job
router.post('/job/create', jobControllers.createJob)

//Update Job
router.put('/job/update/:job_id', auth.isAuthenticated, auth.isAdmin, jobControllers.updateJob)

//Show Job by ID
router.get('/job/:id', jobControllers.singleJob)

//Show Jobs
router.get('/jobs', jobControllers.showJobs)


router.get('/jobs/showallJobs', jobControllers.showallJobs)

//Show Jobs
router.delete('/jobs/delete/:id', auth.isAuthenticated, auth.isAdmin, jobControllers.deleteJob)

module.exports = router