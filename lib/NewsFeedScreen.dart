import 'package:flutter/material.dart';
import 'WatchlistScreen.dart';
import 'StockDataScreen.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeed();
}

class _NewsFeed extends State<NewsFeedScreen> {
  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: StockManager.SavedStocks.length,
              itemBuilder: (context, index) {
                final Stock = StockManager.SavedStocks[index];
                return ListTile(
                  title: Text(Stock),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      StockManager.removeStock(Stock);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('$NewsFeed removed from NewsFeed!')),
                      // );
                      setState(() {}); // Refresh the screen after removing the item
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

