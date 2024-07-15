const express = require("express");
const router = require('express').Router();
const authController = require("../controllers/authControllers")
const auth = require("../middleware/auth")

router.get('/', (req, res) => {
    res.send("Hello from NodeJS Server")
})
//Creating Register/createUser API
router.post('/signup', authController.signup)

//Creating Login API
router.post('/signin', authController.signin)

//Creating LogOut API
router.get('/logout', authController.logout)

//Creating Profile API
router.get('/me', auth.isAuthenticated, authController.userProfile)

router.post('/profile', authController.getUser)


router.put('/profile', authController.updateUserProfile)

//Forgot password
router.post('/forgot-password', authController.forgotPassword)

//Reset Password
router.get('/reset-password/:id/:token', authController.resetPassword)

//Set New Password
router.post('/reset-password/:id/:token', authController.setNewPassword)

module.exports = router

