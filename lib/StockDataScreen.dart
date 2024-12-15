import 'package:flutter/material.dart';
import 'stock_api_service.dart';
import 'stock_manager.dart';  // Import the StockManager class

class StockDataScreen extends StatefulWidget {
  @override
  _StockDataScreenState createState() => _StockDataScreenState();
}

class _StockDataScreenState extends State<StockDataScreen> {
  bool isLoading = true;
  String errorMessage = '';
  List<Map<String, dynamic>>? allStockData; // List to hold data for multiple stocks
  List<Map<String, dynamic>>? allStockDataBackup; // Backup to hold original unfiltered stock data
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadStockData(); // Load stock data when the screen is initialized
  }

  // Function to load stock data for multiple stocks from the API
  Future<void> loadStockData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = ''; // Reset error message
      });

      // Fetch stock data for 10 stocks (AAPL, GOOG, MSFT, AMZN, TSLA, etc.)
      List<String> stocks = ['AAPL', 'GOOG', 'MSFT', 'AMZN', 'TSLA', 'NFLX', 'NVDA', 'META', 'SPY', 'AMD'];
      List<Map<String, dynamic>> fetchedData = [];

      for (String stock in stocks) {
        Map<String, dynamic> data = await StockApiService().fetchStockData([stock]);
        
        // Manually add the symbol to the data to ensure it's displayed
        data['symbol'] = stock;
        
        fetchedData.add(data);
      }

      setState(() {
        allStockData = fetchedData; // Save fetched data for all stocks
        allStockDataBackup = List.from(fetchedData); // Create a backup of the original data
        isLoading = false; // Update the loading state
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading
        errorMessage = 'Error loading stock data: $e'; // Set error message
      });
    }
  }

  // Function to add stock to watchlist
  void addToWatchlist(String stock) {
    StockManager.addStock(stock); // Add stock to watchlist using StockManager
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$stock added to Watchlist!')),
    );
  }

  // Function to search stocks
  void searchBook(String query) {
    if (allStockDataBackup == null || allStockData == null) {
      return; // Return early if data is not loaded yet
    }

    if (query.isEmpty) {
      setState(() {
        allStockData = List.from(allStockDataBackup!); // Restore the original data
      });
    } else {
      final suggestions = allStockDataBackup!.where((stock) {
        final symbol = stock['symbol'].toLowerCase();
        final input = query.toLowerCase();
        return symbol.contains(input);
      }).toList();

      setState(() {
        allStockData = suggestions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Data')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
                : allStockData != null
                    ? Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.fromLTRB(16, 5, 16, 16),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    controller.clear();
                                    searchBook(''); // Clear the search and reset the list
                                  },
                                ),
                                hintText: 'Find Stock',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                              ),
                              onChanged: searchBook,
                            ),
                          ),
                          // Wrap ListView.builder in an Expanded widget
                          Expanded(
                            child: ListView.builder(
                              itemCount: allStockData!.length,
                              itemBuilder: (context, index) {
                                var stock = allStockData![index];
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      'Stock: ${stock['symbol']}',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Current Price: \$${stock['c']}'),
                                        Text('High: \$${stock['h']}'),
                                        Text('Low: \$${stock['l']}'),
                                        Text('Open: \$${stock['o']}'),
                                        Text('Previous Close: \$${stock['pc']}'),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        addToWatchlist(stock['symbol']); // Add stock to watchlist
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(child: Text('No stock data available')),
      ),
    );
  }
}
