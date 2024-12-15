import 'package:flutter/material.dart';
import 'stock_manager.dart'; // Import StockManager class

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late Future<List<Map<String, dynamic>>> savedStocksFuture;

  @override
  void initState() {
    super.initState();
    savedStocksFuture = StockManager.getSavedStocks(); // Load saved stocks from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20), // Green color
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: savedStocksFuture, // Get saved stocks data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved stocks found!')); // No saved stocks
          }

          List<Map<String, dynamic>> savedStocks = snapshot.data!;

          return Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: savedStocks.length, // Number of saved stocks
                  itemBuilder: (context, index) {
                    final stock = savedStocks[index]; // Get full stock data
                    return Card(
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
                          icon: const Icon(Icons.remove), // Icon to remove from the watchlist
                          onPressed: () async {
                            await StockManager.removeStock(stock['symbol']);
                            setState(() {
                              savedStocksFuture = StockManager.getSavedStocks(); // Refresh the list
                            });

                            // Show a confirmation SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${stock['symbol']} removed from Watchlist!')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen (StockDataScreen)
                },
                child: const Text("Back to Home Screen"),
              ),
            ],
          );
        },
      ),
    );
  }
}
