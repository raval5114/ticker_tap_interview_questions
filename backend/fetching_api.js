const axios = require('axios');

// Function to fetch data based on a symbol
async function fetchingData(symbol) {
    try {
        const response = await axios.get(
            `https://finnhub.io/api/v1/quote?symbol=${symbol}&token=ct1nmqhr01qoprggpfp0ct1nmqhr01qoprggpfpg`
        );
        return response.data; // Return the API response data
    } catch (error) {
        console.error(`Error fetching data for symbol ${symbol}: ${error.message}`);
        throw error; // Re-throw the error to let the caller handle it
    }
}

// Function to limit concurrency for API calls
async function limitConcurrency(items, concurrency, handler) {
    const result = [];
    for (let i = 0; i < items.length; i += concurrency) {
        const chunk = items.slice(i, i + concurrency);
        const chunkResults = await Promise.all(chunk.map(async (item) => {
            try {
                return await handler(item);
            } catch (error) {
                console.error(`Error processing item ${item}: ${error.message}`);
                return null; // Handle individual errors without failing the whole process
            }
        }));
        result.push(...chunkResults.filter(Boolean)); // Filter out null results
    }
    return result;
}

// Main function to load stock data
async function loadingData() {
    const stockNames = new Map([
        ['Apple Inc', 'AAPL'],
        ['Microsoft Corp', 'MSFT'],
        ['Tesla Inc', 'TSLA'],
        ['Amazon.com Inc', 'AMZN'],
        ['Alphabet Inc (Google)', 'GOOGL'],
        ['Meta Platforms Inc (Facebook)', 'META'],
        ['NVIDIA Corporation', 'NVDA'],
        ['Netflix Inc', 'NFLX'],
        ['Adobe Inc', 'ADBE'],
        ['Intel Corporation', 'INTC'],
        ['Advanced Micro Devices Inc', 'AMD'],
        ['Cisco Systems Inc', 'CSCO'],
        ['Oracle Corporation', 'ORCL'],
        ['Salesforce Inc', 'CRM'],
        ['PayPal Holdings Inc', 'PYPL'],
        ['Zoom Video Communications', 'ZM'],
        ['Spotify Technology SA', 'SPOT'],
        ['Shopify Inc', 'SHOP'],
        ['Twitter Inc', 'TWTR'],
        ['Uber Technologies Inc', 'UBER']
    ]);
    

    const stocksList = Array.from(stockNames);

    // Use `limitConcurrency` to fetch stock data
    return await limitConcurrency(stocksList, 10, async ([name, symbol]) => {
        const response = await fetchingData(symbol);
        return {
            stockName: name,
            stockSymbol: symbol,
            stockCurrentPrice: response.c,
            stockOpeningPrice: response.o,
            stockClosingPrice: response.pc,
            stockHighestPrice: response.h,
            stockLowestPrice: response.l,
            stockChanges: response.d,
            stockChangesPercent: response.dp,
        };
    });
}

// Export the function
module.exports = loadingData;
