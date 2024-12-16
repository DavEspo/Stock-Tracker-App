import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  bool _initialState = true;
  String _userEmail = '';
  String _errorMessage = ''; // Error message for feedback

  void _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await widget.auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If sign-in is successful, update the state
      setState(() {
        _success = true;
        _userEmail = _emailController.text;
        _initialState = false;
        _errorMessage = ''; // Clear any previous error messages
      });

      // Navigate to the HomeScreen only after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(auth: widget.auth)),
      );
    } catch (e) {
      // Catch and display the error message
      setState(() {
        _success = false;
        _initialState = false;
        _errorMessage = e.toString(); // Set the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmailPasswordForm(
              auth: widget.auth,
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              onSubmit: _signInWithEmailAndPassword,
              errorMessage: _errorMessage,
              initialState: _initialState,
              success: _success,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailPasswordForm extends StatelessWidget {
  const EmailPasswordForm({
    Key? key,
    required this.auth,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.errorMessage,
    required this.initialState,
    required this.success,
  }) : super(key: key);

  final FirebaseAuth auth;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final String errorMessage;
  final bool initialState;
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter an email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a password';
              }
              return null;
            },
            obscureText: true, // Hide password
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  onSubmit(); // Call the sign-in method
                }
              },
              child: Text('Submit'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              initialState
                  ? 'Please sign in'
                  : success
                      ? 'Successfully signed in'
                      : errorMessage.isNotEmpty
                          ? 'Sign in failed: $errorMessage'
                          : 'Unknown error',
              style: TextStyle(color: success ? Colors.green : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
