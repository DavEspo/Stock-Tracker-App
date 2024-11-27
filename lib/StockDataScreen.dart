import 'package:flutter/material.dart';

const allStocks = [
  'Bitcoin',
];


class StockDataScreen extends StatefulWidget {
  const StockDataScreen({super.key});

  @override
  State<StockDataScreen> createState() => StockDataDisplay();
}

class StockDataDisplay extends State<StockDataScreen> {
  List<String> Stocks = allStocks;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Data Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body:Column(
        children: [
          SizedBox(
            height: 5
          ),
          SizedBox(
            width: 400,
            child: Text(
              '  Search Stock Below:',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            )
          ),
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
                    searchBook('');
                  }
                ),
                hintText: 'Find Stock',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue)
                )
              ),
              onChanged: searchBook,
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Stocks.length,
              itemBuilder: (context, index) {
                final Stock = Stocks[index];
                return Container(
                  child: _buildStockTile(context, Stock),
                  decoration: BoxDecoration(
                    border: Border.all(width: .05)
                  )
                );
              }
            ),
          ),
        ]
      )
    );
  }

  void searchBook(String query) {
    final suggestions = allStocks.where((Stock) {
      final StockShown = Stock.toLowerCase();
      final input = query.toLowerCase();

      return StockShown.contains(input);
    }).toList();

    setState(() => Stocks = suggestions);
  }

  // Helper method to create a stock tile
  Widget _buildStockTile(BuildContext context, String StockName) {
    return ListTile(
      title: Text(StockName),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          StockManager.addStock(StockName);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$StockName added to favorites!')),
          );
        },
      ),
      onTap: () {
        if (StockName == 'Bitcoin') {
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
        title: Text('Bitcoin data:'),
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(''),
          // Text('', style: TextStyle(fontSize: 25)),
        ],
      )
    );
  }
}

class StockManager { // This manages list of saved stocks to the watchlist screen
  static final List<String> _SavedStocks = [];

  static List<String> get SavedStocks => _SavedStocks;

  static void addStock(String Stock) {
    if (!_SavedStocks.contains(Stock)) {
      _SavedStocks.add(Stock);
    }
  }

  static void removeStock(String Stock) {
    _SavedStocks.remove(Stock);
  }
}