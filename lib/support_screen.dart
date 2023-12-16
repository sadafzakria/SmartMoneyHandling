import 'package:flutter/material.dart';


class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              child: Image.asset(
                'assets/images/smh.png',
                width: 250,
                height: 250,
              ),
            ),

            SizedBox(height: 30,),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.phone),
                  Text('555-555-5555', style: TextStyle(fontSize: 20),),
                  SizedBox(width: 10,),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.email),
                  Text('inquiries@SMHmoney@com', style: TextStyle(fontSize: 20),),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
