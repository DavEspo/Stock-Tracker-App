import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String _apiKey = 'cteho9pr01qt478lvn3gcteho9pr01qt478lvn40'; // API key

  // Fetch news articles from Finnhub API
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://finnhub.io/api/v1/news?category=general&token=$_apiKey'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load news articles');
    }
  }
}
