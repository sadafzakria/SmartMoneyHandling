import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_user_screen.dart';
import 'login_screen.dart';
import 'user.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  Future<String?> retrieveUserIdFromDatabase(String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: user.username)
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
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)));
            },
            child: Icon(Icons.edit, size: 40),
          ),
        ],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: Center(
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
              '${user.username}', // Wrap the expression with {}
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${user.fname}', // Wrap the expression with {}
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              '${user.lname}', // Wrap the expression with {}
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                // Retrieve the user ID from the database based on the username
                String? userId =
                    await retrieveUserIdFromDatabase(user.username);

                // If the user ID is retrieved, proceed with deletion
                if (userId != null) {
                  // Show a confirmation dialog before deleting the account
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Delete'),
                        content: Text(
                            'Are you sure you want to delete your account?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); // Dismiss the dialog and return false
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                  true); // Dismiss the dialog and return true
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );

                  // If the user confirms the delete, proceed with deletion
                  if (confirmDelete == true) {
                    try {
                      // Ensure that userId is not empty or null
                      if (userId.isNotEmpty) {
                        // Delete the user document from Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .delete();

                        // Navigate to the login screen after successful deletion
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      } else {
                        print('User ID is empty or null');
                        // Handle the case where userId is empty or null
                      }
                    } catch (e) {
                      print('Error deleting user: $e');
                      // TODO: Handle the error, show a message, etc.
                    }
                  }
                } else {
                  print('User ID not found');
                  // Handle the case where the user ID is not found
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text(
                'Delete Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
