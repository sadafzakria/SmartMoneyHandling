import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_money_handling/home_screen.dart';
import 'package:smart_money_handling/report_and_analysis.dart';
import 'package:smart_money_handling/transaction_report.dart';

class MyAccountsScreen extends StatefulWidget {
  const MyAccountsScreen({super.key});

  @override
  State<MyAccountsScreen> createState() => _MyAccountsScreenState();
}

class _MyAccountsScreenState extends State<MyAccountsScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Text('My Accounts', style: TextStyle(fontSize: 30),),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            SizedBox(height: 20,),
            Row(
                children: [
                  Text('Checkings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ]
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text('View Transaction History')
                ),
                Container(
                  height: 25,
                  width: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text('\$826',  style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                )
              ],
            ),

            SizedBox(height: 20,),
            Row(
                children: [
                  Text('Savings 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ]
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text('View Transaction History')
                ),
                Container(
                  height: 25,
                  width: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text('\$226',  style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                )
              ],
            ),

            SizedBox(height: 20,),
            Row(
                children: [
                  Text('Savings 2', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ]
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text('View Transaction History')
                ),
                Container(
                  height: 25,
                  width: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text('\$8226', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                )
              ],
            ),
            SizedBox(height: 60,),
            IconButton(onPressed: (){}, icon: Icon(Icons.add, size: 60, color: Colors.green,))
          ],
        ),
      ),
    );
  }
}
