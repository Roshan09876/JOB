const express = require("express");
const morgan = require("morgan");
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const dotenv = require("dotenv");
const connectDB = require("./database/db");
const cors = require("cors");
const errorHandler = require("./middleware/error");
const authRoutes = require("./routes/authRoutes");
const cloudinary = require('cloudinary').v2; // Ensure using v2
const acceptMultimedia = require('connect-multiparty');

// Making express app
const app = express();

// Just to understand the json data 
app.use(express.json());

// Middleware ()
app.use(morgan('dev'));
app.use(bodyParser.json({ limit: '5mb' }));
app.use(bodyParser.urlencoded({
    limit: '5mb',
    extended: true,
}));
app.use(cookieParser());

dotenv.config();

connectDB();

// Cloudinary config
cloudinary.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

// For Uploading file 
app.use(acceptMultimedia());

// Connecting backend to the frontend
const corsOptions = {
    origin: [true],
    credentials: true,
    optionSuccessStatus: 200
};

app.use(cors(corsOptions));
app.set('view engine', 'ejs');
app.use(express.urlencoded({
    extended: true
}));

// Testing Route fetching Route form AuthRoutes.js file
app.use('/test', authRoutes);

// user route
app.use("/api", require("./routes/authRoutes"));
app.use("/api", require("./routes/userRoutes"));
app.use("/api", require('./routes/jobsTypeRoutes'));
app.use("/api", require('./routes/jobRoutes'));
app.use("/api", require('./routes/bookmarkRoutes'));

// Handling Error
app.use(errorHandler);
const PORT = process.env.PORT
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`)
})
// Export the app instance for testing purposes
module.exports = app;
