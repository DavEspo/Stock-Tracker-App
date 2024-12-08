import 'package:flutter/material.dart';

const allStocks = [
  'Bitcoin',
  'Ethereum',
  'Tesla',
  'Amazon',
  'Apple', // Add more stocks if needed
];

class StockDataScreen extends StatefulWidget {
  const StockDataScreen({super.key});

  @override
  State<StockDataScreen> createState() => StockDataDisplay();
}

class StockDataDisplay extends State<StockDataScreen> {
  List<String> stocks = allStocks;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Data Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          const SizedBox(
            width: 400,
            child: Text(
              '  Search Stock Below:',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 5, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    searchStock('');
                  },
                ),
                hintText: 'Find Stock',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: searchStock,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                return Container(
                  child: _buildStockTile(context, stock),
                  decoration: BoxDecoration(
                    border: Border.all(width: .05),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchStock(String query) {
    final suggestions = allStocks.where((stock) {
      final stockShown = stock.toLowerCase();
      final input = query.toLowerCase();

      return stockShown.contains(input);
    }).toList();

    setState(() => stocks = suggestions);
  }

  // Helper method to create a stock tile
  Widget _buildStockTile(BuildContext context, String stockName) {
    return ListTile(
      title: Text(stockName),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          StockManager.addStock(stockName);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$stockName added to WatchList!')),
          );
        },
      ),
      onTap: () {
        // You can add detailed view for each stock later
        if (stockName == 'Bitcoin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Bitcoin()),
          );
        }
      },
    );
  }
}

class Bitcoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitcoin Data'),
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: const Center(
        child: Text(
          'Bitcoin data goes here!',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}

class StockManager {
  static final List<String> _savedStocks = [];

  static List<String> get savedStocks => _savedStocks;

  static void addStock(String stock) {
    if (!_savedStocks.contains(stock)) {
      _savedStocks.add(stock);
    }
  }

  static void removeStock(String stock) {
    _savedStocks.remove(stock);
  }
}
