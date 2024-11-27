import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'WelcomeScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: SizedBox.expand(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back to Home Screen"),
          ),
          SizedBox(height: 20), // Adding some space
          ElevatedButton(
            onPressed: () async {
              // Call the logout functionality
              await DatabaseHelper().logoutUser(); // Implement in DatabaseHelper
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()), // Navigate to login screen
              );
            },
            child: Text("DELETE ACCOUNT"),
          ),
        ],
      ),)
    );
  }
}