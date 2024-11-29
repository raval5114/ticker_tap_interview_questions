const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

// Import routes
const stockRoutes = require('./routes');
const fetchData = require('./fetching_api');

// Middleware
app.use(cors());
app.use(express.json());

// Use the routes
app.use('/stock_app', stockRoutes); // All routes in `route.js` will be prefixed with `/stock_app`

// Calling the API made from Axios
//app.get('/fetchedData', fetchData); // Attach the fetchData function as a route handler

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
