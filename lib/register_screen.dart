import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'user.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key});

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
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                "Already have an Account? Login",
                style: TextStyle(color: Colors.blue),
              ),
            ),
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
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // GlobalKey for Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Toggle for showing/hiding the password
  bool _showPassword = false;

  Future<bool> isUsernameUnique(String username) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      return querySnapshot.docs.isEmpty;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error checking username uniqueness: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<void> createUser(User user) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('users').doc();
      user.id = docUser.id;
      final json = user.toJson();
      await docUser.set(json);
      _formKey.currentState?.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating user: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: fnameController,
            decoration: InputDecoration(labelText: '*First Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: lnameController,
            decoration: InputDecoration(labelText: '*Last Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(labelText: '*Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: '*Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final username = usernameController.text;

                // Check if the username is unique
                final isUnique = await isUsernameUnique(username);

                if (!isUnique) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Username is already taken. Please choose another.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User registration in progress...'),
                    duration: Duration(seconds: 2),
                  ),
                );

                await createUser(
                  User(
                    fname: fnameController.text,
                    lname: lnameController.text,
                    username: username,
                    password: passwordController.text,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User created successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[900],
            ),
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

