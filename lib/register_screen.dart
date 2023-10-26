import 'package:flutter/material.dart';
import 'nav_menu.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key});

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
                    height: 150, // Set the desired height for your logo
                    width: 150, // Set the desired width for your logo
                  ),
                  SizedBox(height: 10), // Add space between image and title
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String username = "";
  String password = "";
  String reenteredPassword = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: '*First Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            onSaved: (value) {
              firstName = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '*Last Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onSaved: (value) {
              lastName = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '*Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
            onSaved: (value) {
              username = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '*Password'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
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
                // Here, you can process the registration data.
                // After successful registration, navigate to the nav_menu screen.
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavBar()));
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green[900], // Set the button color to green
            ),
            child: Text(
              'Sign Up',
              style: TextStyle(color: Colors.white), // Set the text color to white
            ),
          ),
        ],
      ),
    );
  }
}
