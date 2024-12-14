import 'package:flutter/material.dart';
import 'stock_manager.dart'; // Import StockManager class

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20), // Green color
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: StockManager.savedStocks.length, // Number of saved stocks
              itemBuilder: (context, index) {
                final stock = StockManager.savedStocks[index]; // Get stock symbol
                return ListTile(
                  title: Text(stock), // Display the stock symbol
                  trailing: IconButton(
                    icon: const Icon(Icons.remove), // Icon to remove from the watchlist
                    onPressed: () {
                      // Remove the stock from the saved list
                      setState(() {
                        StockManager.removeStock(stock);
                      });

                      // Show a confirmation SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$stock removed from Watchlist!')),
                      );
                    },
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
      ),
    );
  }
}
