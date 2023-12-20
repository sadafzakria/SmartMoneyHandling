import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'classes/user.dart';
import "login_screen.dart";

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
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
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ResetPasswordForm(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "Remember your password? Log in",
                  style: TextStyle(
                    color: Colors.blue,
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

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key});

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String newPassword = "";
  bool showPassword = false;

  // Password validation regex (adjust as needed)
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@$!%*?&]).{8,}$',
  );

  Future<void> resetPassword(String username, String newPassword) async {
    try {
      String? userId = await retrieveUserIdFromDatabase(username);

      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'password': newPassword,
        });

        // Navigate to the success screen or perform other actions as needed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username not found. Unable to reset password.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error resetting password: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<String?> retrieveUserIdFromDatabase(String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;
        return userId;
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user ID: $e');
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
              labelText: 'New Password',
              suffixIcon: IconButton(
                icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
            ),
            obscureText: !showPassword,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your new password';
              }
              if (!passwordRegex.hasMatch(value)) {
                return 'Password: 8 characters, including letters, numbers, and specials.';
              }
              return null;
            },
            onSaved: (value) {
              newPassword = value!;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                await resetPassword(username, newPassword);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green[900],
            ),
            child: Text(
              'Reset Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
