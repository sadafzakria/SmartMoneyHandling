import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as location_package;
import 'package:geocoding/geocoding.dart';
import 'edit_user_screen.dart';
import 'login_screen.dart';
import 'classes/user.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;
  final Function(String) onProfileImageUpdated;

  const UserProfileScreen({
    Key? key,
    required this.user,
    required this.onProfileImageUpdated,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}
class _UserProfileScreenState extends State<UserProfileScreen> {
  late User user; // Define user property in the state
  location_package.Location location = location_package.Location();
  String locationInfo = 'My Location:\nN/A';
  bool isFetchingLocation = true;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    initLocation();
  }

  Future<void> initLocation() async {
    setState(() {
      isFetchingLocation = true;
    });

    await location.requestPermission();

    try {
      location_package.LocationData currentLocation =
      await location.getLocation();
      reverseGeocode(
          currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);
    } catch (e) {
      print('Error getting current location: $e');
    }

    setState(() {
      isFetchingLocation = false;
    });

    location.onLocationChanged.listen(
          (location_package.LocationData currentLocation) {
        reverseGeocode(
            currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);
      },
    );
  }

  Future<void> reverseGeocode(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          locationInfo = 'My Location:\n${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      print('Error performing reverse geocoding: $e');
    }
  }

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
            onTap: () async {
              // Open EditProfileScreen and wait for the result
              final updatedUser = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    user: user,
                    profileImageUrl: '',
                    onProfileImageUpdated: widget.onProfileImageUpdated,
                  ),
                ),
              );

              // Check if user information was updated
              if (updatedUser != null && updatedUser is User) {
                // Update the state with the new user information
                setState(() {
                  user = updatedUser;
                });
              }
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
            CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(user.profileImageUrl),
            ),
            SizedBox(height: 20),
            Text(
              '${user.username}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${user.fname}',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              '${user.lname}',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 40,
              width: 350,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pin_drop, color: Colors.green[900], size: 32),
                    isFetchingLocation
                        ? CircularProgressIndicator()
                        : Flexible(
                      child: Text(
                        locationInfo,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.visible, // Set overflow to visible
                      ),
                    ),
                  ],
                ),
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
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        print('User ID is empty or null');
                        // Handle the case where userId is empty or null
                      }
                    } catch (e) {
                      print('Error deleting user: $e');
                    }
                  }
                } else {
                  print('User ID not found');
                  // Handle the case where the user ID is not found
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
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
