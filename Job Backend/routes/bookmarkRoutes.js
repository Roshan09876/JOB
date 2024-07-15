const express = require("express");
const router = require('express').Router();
const bookmarkController = require('../controllers/bookmarkController');
const verifyToken = require("../middleware/verifytoken")

//Post
router.post('/book', bookmarkController.createBookmark)

//Delete
router.delete('/book/:id', bookmarkController.deleteBookmark)

//Get
router.get('/book/:userId', bookmarkController.getBookmark)

module.exports = router
