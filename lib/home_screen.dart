import 'package:flutter/material.dart';
import 'nav_menu.dart'; // Import the NavMenu if needed
import 'user_profile_screen.dart'; // Import the UserProfileScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileScreen()));
              },
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(Icons.account_circle, size: 40), // User icon
              ),
            ),
            Text(
              "Home",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Current Budget Expenses", style: TextStyle(fontSize: 20)),
            DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text("Type")),
                DataColumn(label: Text("Amount")),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text("Expense Type 1")),
                    DataCell(Text("Amount 1")),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text("Expense Type 2")),
                    DataCell(Text("Amount 2")),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text("Expense Type 3")),
                    DataCell(Text("Amount 3")),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text("Expense Type 4")),
                    DataCell(Text("Amount 4")),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text("Expense Type 5")),
                    DataCell(Text("Amount 5")),
                  ],
                ),
                // Add more rows as needed
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.green[100],
              child: Center(
                child: Text(
                  "Your efficient budgeting is catching up to you! Your savings are up by - - %",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                  textAlign: TextAlign.center, // Align the text to the center
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
