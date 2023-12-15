import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'classes/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  String profileImageUrl;
  final Function(String) onProfileImageUpdated; // Callback function

  EditProfileScreen({
    Key? key,
    required this.user,
    required this.profileImageUrl,
    required this.onProfileImageUpdated,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool _showPassword = false;

  List<String> unsplashImages = [];

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    passwordController = TextEditingController(text: widget.user.password);
    // Fetch Unsplash images on initialization
    fetchUnsplashImages();
  }

  Future<void> fetchUnsplashImages() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.unsplash.com/photos/random?count=6'), // Change count as needed
        headers: {
          'Authorization': 'Client-ID asSMG9hodGERbXEUjY2P1kYDqp6Yb5HP0dweRFkVPiQ', // Replace with your Unsplash API key
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<String> imageUrls =
        List<String>.from(data.map((item) => item['urls']['regular'] as String));

        setState(() {
          unsplashImages = imageUrls;
        });
      } else {
        print('Failed to load Unsplash images: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching Unsplash images: $e');
    }
  }

  Future<void> updateUser() async {
    try {
      String? userId = await retrieveUserIdFromDatabase(widget.user.username);

      if (userId != null) {
        String newUsername = usernameController.text;
        String newPassword = passwordController.text;

        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'username': newUsername,
          'password': newPassword,
          'profileImageUrl': widget.profileImageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Invoke the callback to notify the parent (UserProfileScreen)
        widget.onProfileImageUpdated(widget.profileImageUrl);

        Navigator.of(context).pop(new User(
          id: widget.user.id,
          username: newUsername,
          password: newPassword,
          fname: widget.user.fname,
          lname: widget.user.lname,
          profileImageUrl: widget.profileImageUrl,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not found. Unable to update profile.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<String?> retrieveUserIdFromDatabase(String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: widget.user.username)
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
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(widget.profileImageUrl),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Fetch Unsplash images when "Add Photo" button is pressed
                  fetchUnsplashImages();
                },
                child: Text('Add Photo'),
              ),
              if (unsplashImages.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: unsplashImages.map((imageUrl) {
                    return GestureDetector(
                      onTap: () {
                        // Set the selected image as the profile picture
                        setState(() {
                          widget.profileImageUrl = imageUrl;
                        });

                        // Call the callback to update the profile image in the parent widget (HomeScreen)
                        widget.onProfileImageUpdated(imageUrl);
                      },
                      child: Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
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
}
