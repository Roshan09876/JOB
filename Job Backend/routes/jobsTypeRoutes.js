const express = require("express");
const router = require('express').Router();
const jobTypeController = require('../controllers/jobTypeControllers');
const auth = require('../middleware/auth')

//Jobtype Routes


//api/type/create
router.post('/type/create', auth.isAuthenticated, auth.isAdmin, jobTypeController.createJobType)

//api/type/jobs
router.get('/type/jobs', jobTypeController.allJobsType)

//api/type/update/type_id
router.put('/type/update/:type_id',auth.isAuthenticated, auth.isAdmin, jobTypeController.updateJobType)

//api/type/update/type_id
router.delete('/type/delete/:type_id',auth.isAuthenticated, auth.isAdmin, jobTypeController.deleteJobType)


module.exports = router