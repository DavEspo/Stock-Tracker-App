import 'package:flutter/material.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              // children: _buildDaySections(context),
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

  // List<Widget> _buildStockSections(BuildContext context) {
  //   List<Widget> StockSections = [];
  // }

  Widget _buildStockSection(String day, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(day, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: Text('Stockname'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // children: SavedStocks.isNotEmpty
              //     ? SavedStocks.map((recipe) {
              //         return ListTile(
              //           title: Text(recipe),
              //           trailing: IconButton(
              //             icon: const Icon(Icons.remove),
              //             onPressed: () {
              //               // MealPlanManager.removeFromSavedStocks();
              //               // ScaffoldMessenger.of(context).showSnackBar(
              //               //   SnackBar(content: Text('$Stock removed from SavedStocks!')),
              //               // );
              //             },
              //           ),
              //         );
              //       }).toList()
              //     : [const Text('')],
            ),
          ),
        ],
      ),
    );
  }
}

class SavedStocksManager {//this manages Fvorite Screen to Meal Plan Screen 

  static void removeFromWatchlist(String day, String recipe) {

  }
}