import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_money_handling/home_screen.dart';
import 'package:smart_money_handling/report_and_analysis.dart';
import 'package:smart_money_handling/transaction_report.dart';

class FinancialGoalsScreen extends StatefulWidget {
  const FinancialGoalsScreen({super.key});

  @override
  State<FinancialGoalsScreen> createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Text('What are your financial goals?', style: TextStyle(fontSize: 25),),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Being Debt Free', style: TextStyle(fontSize: 13),),
                      value: true,
                      onChanged: (value){}
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Building an emergency fund', style: TextStyle(fontSize: 13),),
                      value: false,
                      onChanged: (value){}
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Travelling more', style: TextStyle(fontSize: 13),),
                      value: true,
                      onChanged: (value){}
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Investing', style: TextStyle(fontSize: 13),),
                      value: false,
                      onChanged: (value){}
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Being more resourceful', style: TextStyle(fontSize: 13),),
                      value: true,
                      onChanged: (value){}
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Saving for retirement', style: TextStyle(fontSize: 13),),
                      value: false,
                      onChanged: (value){}
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Buying a home', style: TextStyle(fontSize: 13),),
                      value: false,
                      onChanged: (value){}
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CheckboxListTile(
                      title: Text('Budgeting better', style: TextStyle(fontSize: 13),),
                      value: true,
                      onChanged: (value){}
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {},
                child: Text('Next')
            ),
          ],
        ),
      ),
    );
  }
}
