import 'package:flutter/material.dart';
import 'nav_menu.dart';
import 'register_screen.dart'; // Import the RegisterScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
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
                    'assets/images/smh.png', // Update this path to your image location
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
            LoginForm(),
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
  const LoginForm({Key? key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false; // Toggle for showing/hiding the password
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Here, you can process the login data.
                // After successful login, navigate to the nav_menu screen.
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavBar()));
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
