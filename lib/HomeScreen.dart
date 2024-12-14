import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'StockDataScreen.dart';  // Make sure you import StockDataScreen
import 'WatchlistScreen.dart';  // Make sure you import WatchListScreen
import 'NewsFeedScreen.dart';   // Make sure you import NewsFeedScreen
import 'SettingsScreen.dart';   // Make sure you import SettingsScreen
import 'LoginScreen.dart';      // Import LoginScreen for logout navigation

class Home extends StatefulWidget {
  Home({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: Column(
        children: [
          // Stock Data Screen Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to StockDataScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StockDataScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78),
              ),
              child: const Text(
                "Stock Data Screen",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          
          // Watchlist Screen Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to WatchlistScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WatchListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78),
              ),
              child: const Text(
                "Watchlist",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          
          // News Feed Screen Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to NewsFeedScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsFeedScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78),
              ),
              child: const Text(
                "News Feed Screen",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          
          // Settings Screen Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to SettingsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78),
              ),
              child: const Text(
                "Settings Screen",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Logout Button
          ElevatedButton(
            onPressed: () {
              _signOut(context);  // Call logout function
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login(auth: widget.auth)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 165, 78),
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // Sign out function
  void _signOut(BuildContext context) async {
    await widget.auth.signOut();
    // Optionally show a SnackBar confirming the sign out
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signed out successfully')),
    );
  }
}
