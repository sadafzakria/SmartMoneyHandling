import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_money_handling/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green[900],
          secondary: Colors.green[900],
        ),
      ),
      home: SMHapp(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // Dismiss the keyboard when tapping outside of a text field
            FocusScope.of(context).unfocus();
          },
          child: child,
        );
      },
    );
  }
}

class SMHapp extends StatelessWidget {
  const SMHapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
