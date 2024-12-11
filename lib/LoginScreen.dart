import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_tracker_app/database_helper.dart';
import 'HomeScreen.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;

  @override
  GoToLogin createState() => GoToLogin();
}

class GoToLogin extends State<Login> {
  // final FirebaseAuth _auth = RegisterEmailSection(auth: auth).auth;
  
  // void _signOut() async {
  //   await _auth.signOut();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text('Signed out successfully'),
  //   ));
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        // actions: <Widget>[
        //   ElevatedButton(
        //     onPressed: () {
        //       _signOut();
        //     },
        //     child: Text('Sign Out'),
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // RegisterEmailSection(auth: _auth),
            EmailPasswordForm(auth: widget.auth),
          ],
        ),
      ),
    );
  }
}

class EmailPasswordForm extends StatefulWidget {
  EmailPasswordForm({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  
  @override
  _EmailPasswordFormState createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  bool _initialState = true;
  String _userEmail ='';
  
  void _signInWithEmailAndPassword() async {
    try {
      await widget.auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _success = true;
        _userEmail = _emailController.text;
        _initialState = false;
      });
    } catch (e) {
      setState(() {
        _success = false;
        _initialState = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text('Test sign in with email and password'),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value?.isEmpty??true) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value?.isEmpty??true) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _signInWithEmailAndPassword();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home(auth: widget.auth))
                  );
                }
              },
              child: Text('Submit'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _initialState
                  ? 'Please sign in'
              : _success
                  ? 'Successfully signed in $_userEmail'
                  : 'Sign in failed',
              style: TextStyle(color: _success ? Colors.green : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key, required this.title});

//   final String title;

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final dbHelper = DatabaseHelper();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 13, 222, 20),
//         title: Text(widget.title),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: TextFormField(
//                   controller: email,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Email",
//                   ),
//                   validator: _validateInput,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: TextFormField(
//                   controller: password,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Password",
//                   ),
//                   obscureText: true,
//                   validator: _validateInput,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: Center(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         final userList = await dbHelper.fetchUser(email.text, password.text);
//                         if (userList.isNotEmpty) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => const HomePage()),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Wrong email or password')),
//                           );
//                         }
//                       }
//                     },
//                     child: const Text("Submit"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String? _validateInput(String? value) {
//     if (value == null || value.isEmpty) {
//       return "This field cannot be empty";
//     }
//     return null;
//   }
// }