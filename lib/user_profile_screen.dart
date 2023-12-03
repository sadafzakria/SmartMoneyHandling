import 'package:flutter/material.dart';
import 'edit_user_screen.dart'; // Import the EditUserScreen

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen()));
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
              color: Colors.green[900], // Customize the color
            ),
            SizedBox(height: 20),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'First Name',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              'Last Name',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add delete account functionality here
                // This is where you would implement the logic to delete the user's account
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
