import 'package:flutter/material.dart';
import 'news_api_service.dart'; // Import the NewsApiService

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  bool isLoading = true;
  String errorMessage = '';
  List<Map<String, dynamic>>? newsArticles; // List to hold news articles

  @override
  void initState() {
    super.initState();
    loadNewsData(); // Load news data when the screen is initialized
  }

  // Function to load news data from the API
  Future<void> loadNewsData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = ''; // Reset error message
      });

      newsArticles = await NewsApiService().fetchNews();

      setState(() {
        isLoading = false; // Update the loading state
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading
        errorMessage = 'Error loading news articles: $e'; // Set error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Feed')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
                : newsArticles != null
                    ? ListView.builder(
                        itemCount: newsArticles!.length,
                        itemBuilder: (context, index) {
                          var article = newsArticles![index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(
                                article['headline'], // Article headline
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Source: ${article['source']}'), // Source of the news
                                  SizedBox(height: 4),
                                  Text(article['summary'] ?? 'No summary available'), // Article summary
                                ],
                              ),
                              onTap: () {
                                // Open the full article in the browser
                                String? url = article['url'];
                                if (url != null) {
                                  // Open the link
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Open Article'),
                                        content: Text('Do you want to open this article?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Open URL in browser
                                              Navigator.of(context).pop();
                                              
                                            },
                                            child: Text('Open'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        },
                      )
                    : Center(child: Text('No news available')),
      ),
    );
  }
}
