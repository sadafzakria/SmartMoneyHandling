import 'package:flutter/material.dart';
import 'classes/user.dart';
import 'package:smart_money_handling/home_screen.dart';
import 'package:smart_money_handling/logout_screen.dart';
import 'package:smart_money_handling/report_and_analysis.dart';
import 'package:smart_money_handling/transaction_report.dart';
import 'package:smart_money_handling/support_screen.dart';
import 'package:smart_money_handling/accounts_screen.dart';

class NavBar extends StatefulWidget {
  final User user;
  NavBar({Key? key, required this.user}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Smart Money Handling"),
          backgroundColor: Colors.green[900],
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LogoutScreen()));
              },
            ),
          ],
        ),
        backgroundColor: Colors.lightGreen[100],
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              // Add your tab content here!
              HomeScreen(user: widget.user),
              ReportAndAnalysis(),
              MyAccountsScreen(),
              TransactionReport(),
              SupportScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.green[900],
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Tab(
                icon: Icon(Icons.money),
                child: Text(
                  'Financial\nGoals',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                icon: Icon(Icons.attach_money),
                child: Text(
                  'Account\nHistory',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                icon: Icon(Icons.sticky_note_2_outlined),
                child: Text(
                  'Reports',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                icon: Icon(Icons.help_outline),
                child: Text(
                  'Help\nCenter',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
        ),
      ),
    );
  }
}
