import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'WelcomeScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Delete account from Firebase Authentication
  Future<void> _deleteAccount(BuildContext context) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No user is currently logged in!")),
        );
        return;
      }

      // Step 1: Delete user data from Firestore (if applicable)
      await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

      // Step 2: Delete user from Firebase Authentication
      await user.delete();

      // Step 3: Logout the user and navigate to the welcome screen
      // await DatabaseHelper().logoutUser(); // Implement in DatabaseHelper (for local database)
      
      // Navigate to WelcomeScreen (Login screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account deleted successfully!")),
      );
    } catch (e) {
      // Handle errors (e.g., user may not have re-authenticated)
      print("Error deleting account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting account: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 13, 222, 20),
      ),
      body: SizedBox.expand(
        child: Column(
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
                // Show confirmation dialog before deleting the account
                bool confirmDelete = await _showDeleteConfirmationDialog(context);
                if (confirmDelete) {
                  // Call the delete account functionality
                  await _deleteAccount(context);
                }
              },
              child: Text("DELETE ACCOUNT"),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a confirmation dialog before deleting the account
  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This action cannot be undone. Your account and data will be deleted permanently.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User chose not to delete
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed deletion
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    ) ?? false; // Ensure we return false if the dialog is dismissed (for example, if the user taps outside)
  }
}
