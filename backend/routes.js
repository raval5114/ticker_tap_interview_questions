const express = require('express');
const fs = require('fs');
const path = require('path');
const loadingData = require('./fetching_api'); // Ensure this function is implemented correctly
const router = express.Router();

// Path to stocks.json
const stocksFilePath = path.resolve(__dirname, 'assets', 'stocks.json');

// Function to load stocks from the JSON file
const loadStocks = () => {
    try {
        const data = fs.readFileSync(stocksFilePath, 'utf8');
        return JSON.parse(data);
    } catch (err) {
        console.error('Error reading stocks.json:', err.message);
        throw new Error('Failed to load stocks data.');
    }
};

// Define the API for fetching live stock data
router.get('/getStockData', async (req, res) => {
    try {
        const stockData = await loadingData(); // Fetch live data
        res.status(200).json(stockData); // Send the fetched data as a JSON response
    } catch (error) {
        console.error('Error fetching stock data:', error.message);
        res.status(500).json({ error: 'Failed to fetch stock data. Please try again later.' });
    }
});

// Define the API for fetching stock data from stocks.json by name
router.get('/stocks/:name', (req, res) => {
    try {
        const stocks = loadStocks(); // Load data from stocks.json
        const stockName = req.params.name;
        const stock = stocks.find((item) => item.stockName.toLowerCase() === stockName.toLowerCase());
        if (stock) {
            res.json(stock); // Send the matching stock data
        } else {
            res.status(404).json({ message: 'Stock not found' });
        }
    } catch (error) {
        console.error('Error loading stocks:', error.message);
        res.status(500).json({ error: 'Failed to fetch stock data. Please try again later.' });
    }
});

module.exports = router;
