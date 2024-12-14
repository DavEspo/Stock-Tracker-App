import 'package:http/http.dart' as http;
import 'dart:convert';

class StockApiService {
  final String _apiKey = 'cteho9pr01qt478lvn3gcteho9pr01qt478lvn40'; 

  // Fetch stock data for the given list of stock symbols
  Future<Map<String, dynamic>> fetchStockData(List<String> stocks) async {
    if (stocks.isEmpty) {
      throw Exception('No stock symbols provided');
    }

    // For testing, we will fetch data for just the first stock symbol (e.g., 'AAPL')
    final stock = stocks[0];

    final response = await http.get(
      Uri.parse('https://finnhub.io/api/v1/quote?symbol=$stock&token=$_apiKey'),
    );

    if (response.statusCode == 200) {
      // Successfully fetched stock data
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}
