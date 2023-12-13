import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current values
    usernameController = TextEditingController(text: widget.user.username);
    passwordController = TextEditingController(text: widget.user.password);
  }

  Future<String?> retrieveUserIdFromDatabase(String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: widget.user.username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract the document ID from the first document
        String userId = querySnapshot.docs.first.id;
        return userId;
      } else {
        return null; // User not found
      }
    } catch (e) {
      print('Error retrieving user ID: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 175,
                color: Colors.green[900],
              ),
              SizedBox(height: 20),
              Text(
                'Add Photo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Enter new Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter New Password',
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
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Add save functionality
                  updateUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[900],
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateUser() async {
    try {
      // Retrieve user ID from the database
      String? userId = await retrieveUserIdFromDatabase(widget.user.username);

      if (userId != null) {
        // Retrieve updated values from controllers
        String newUsername = usernameController.text;
        String newPassword = passwordController.text;

        // Update user in Firestore using the retrieved user ID
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'username': newUsername,
          'password': newPassword,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        // Pop the EditProfileScreen and pass the updated user information
        Navigator.of(context).pop(new User(
          id: widget.user.id,
          username: newUsername,
          password: newPassword,
          fname: widget.user.fname,
          lname: widget.user.lname,
        ));
      } else {
        // Show error message if user not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not found. Unable to update profile.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
