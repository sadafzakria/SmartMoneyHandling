import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'classes/user.dart';
import 'nav_menu.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.lightGreen[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/smh.png',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            LoginForm(
              onLogin: (user) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NavBar(user: user),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () {
                  // Navigate to the RegisterScreen when "Register Now" is clicked.
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: Text(
                  "Don't have an Account? Register Now",
                  style: TextStyle(
                    color: Colors.blue, // Make the text clickable with a blue color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final Function(User user) onLogin;

  const LoginForm({Key? key, required this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  Future<User?> authenticateUser(String username, String password) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        return User(
          username: username,
          password: password,
          fname: userData['fname'] ?? '',
          lname: userData['lname'] ?? '',
        );
      } else {
        return null; // User not found
      }
    } catch (e) {
      print('Error authenticating user: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (value) {
              username = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
            ),
            obscureText: !_showPassword,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              password = value!;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                User? user = await authenticateUser(username, password);

                if (user != null) {
                  // Pass the user details to the onLogin callback
                  widget.onLogin(user);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => NavBar(user: user)));
                      print(user);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green[900],
            ),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
