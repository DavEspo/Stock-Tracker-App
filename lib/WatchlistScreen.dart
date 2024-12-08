import 'package:flutter/material.dart';
import 'StockDataScreen.dart'; // Make sure to import this so StockManager is accessible

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
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: StockManager.savedStocks.length,
              itemBuilder: (context, index) {
                final stock = StockManager.savedStocks[index];
                return ListTile(
                  title: Text(stock),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
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
              Navigator.pop(context);
            },
            child: const Text("Back to Home Screen"),
          ),
        ],
      ),
    );
  }
}
