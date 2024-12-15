import 'package:cloud_firestore/cloud_firestore.dart';

class StockManager {
  static List<Map<String, dynamic>> savedStocks = []; // Store full stock data locally

  // Firestore collection reference
  static final CollectionReference stockCollection =
      FirebaseFirestore.instance.collection('stocks');

  // Add stock to Firestore and local saved list
  static Future<void> addStock(Map<String, dynamic> stockData) async {
    try {
      // Check if the stock already exists in Firestore
      DocumentSnapshot stockDoc = await stockCollection.doc(stockData['symbol']).get();

      if (!stockDoc.exists) {
        // Add stock to Firestore
        await stockCollection.doc(stockData['symbol']).set(stockData);

        // Add the stock to the local saved list
        savedStocks.add(stockData);

        print("Stock added to Firestore and saved locally: ${stockData['symbol']}");
      } else {
        print("Stock already exists in Firestore: ${stockData['symbol']}");
      }
    } catch (e) {
      print("Error adding stock: $e");
    }
  }

  // Remove stock from Firestore and local saved list
  static Future<void> removeStock(String stockSymbol) async {
    try {
      // Remove stock from Firestore
      await stockCollection.doc(stockSymbol).delete();

      // Remove stock from local saved list
      savedStocks.removeWhere((stock) => stock['symbol'] == stockSymbol);

      print("Stock removed from Firestore and locally: $stockSymbol");
    } catch (e) {
      print("Error removing stock: $e");
    }
  }

  // Fetch saved stocks from Firestore
  static Future<List<Map<String, dynamic>>> getSavedStocks() async {
    try {
      // Get stocks from Firestore
      QuerySnapshot snapshot = await stockCollection.get();

      List<Map<String, dynamic>> stocks = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Update the local list of saved stocks
      savedStocks = stocks;

      return stocks;
    } catch (e) {
      print("Error fetching saved stocks: $e");
      return [];
    }
  }
}
