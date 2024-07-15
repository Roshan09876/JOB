const express = require("express");
const router = require('express').Router();
const userController = require("../controllers/userControllers")
const auth = require("../middleware/auth")

//api/allUsers
router.get('/allusers', auth.isAuthenticated, auth.isAdmin, userController.allUsers)

//api/singleUser - by - id
router.get('/user/:id', auth.isAuthenticated, userController.singleUser)
//api/editUser 
router.put('/user/edit/:id', auth.isAuthenticated, userController.editUser)

//api/deleteUser
router.delete('/admin/user/delete/:id', auth.isAuthenticated, auth.isAdmin, userController.deleteUser)

//api/user/jobHistory
router.post('/user/jobhistory/:userId', userController.createUserJobsHistory)

//get user jobHistory
router.get('/user/jobhistory/:id', userController.getUserJobHistory)

module.exports = router