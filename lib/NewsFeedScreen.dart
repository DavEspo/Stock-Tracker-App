import 'package:flutter/material.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: const Center(
        child: Text(
          'News feed content will go here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
