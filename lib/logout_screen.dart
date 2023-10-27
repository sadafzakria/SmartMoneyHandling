import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_money_handling/home_screen.dart';
import 'package:smart_money_handling/report_and_analysis.dart';
import 'package:smart_money_handling/transaction_report.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Text('You have successfully logged out!', style: TextStyle(fontSize: 23, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),),
            SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {},
              child: Text('Back to main page'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[900],
                minimumSize: Size(100, 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
