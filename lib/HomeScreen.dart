import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'StockDataScreen.dart';
import 'WatchlistScreen.dart';
import 'NewsFeedScreen.dart';
import 'SettingsScreen.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Home> {
  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
        // Removed logout button from the AppBar
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => StockDataScreen()),
                // );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78), // Color for Recipe Screen
              ),
              child: const Text(
                "Stock Data Screen",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => WatchListScreen()),
                // );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78), // Color for Meal Planning Screen
              ),
              child: const Text(
                "Watchlist",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const NewsFeedScreen()),
                // );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78), // Color for Favorite Screen
              ),
              child: const Text(
                "News Feed Screen",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                // );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(370, 60),
                backgroundColor: const Color.fromARGB(255, 7, 165, 78), // Color for Settings Screen
              ),
              child: const Text(
                "Settings Screen",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Logout button
          ElevatedButton(
            onPressed: () {
              _signOut(context);  // Call logout function
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login(auth: widget.auth)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 7, 165, 78), // Logout button color
            ),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // Logout function to navigate back to the LoginPage
  // void _logout(BuildContext context) {
  //   // Navigator.pushReplacement(
  //   //   context,
  //   //   MaterialPageRoute(builder: (context) => const EmailPasswordForm(auth: _MyHomePageState._auth)),
  //   // );
  // }
  void _signOut(BuildContext context) async {
    await widget.auth.signOut();
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const EmailPasswordForm(auth: widget.auth)),
    // );
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text('Signed out successfully'),
  //   ));
  }
}