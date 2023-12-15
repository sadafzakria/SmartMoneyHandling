import 'package:flutter/material.dart';
import 'user_profile_screen.dart';
import 'classes/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [
    Expense("", ""),
    Expense("", ""),
    Expense("", ""),
  ];

  double totalAmount = 0.0;
  bool showTotalAmount = false;

  // Callback function to update the profile image in HomeScreen
  void updateProfileImage(String newProfileImage) {
    setState(() {
      widget.user.profileImageUrl = newProfileImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.user.profileImageUrl),
              ),
              onPressed: () async {
                // Open UserProfileScreen and wait for the result
                final updatedProfileImage = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      user: widget.user,
                      onProfileImageUpdated: updateProfileImage,
                    ),
                  ),
                );

                // Check if the profile image was updated
                if (updatedProfileImage != null && updatedProfileImage is String) {
                  // Update the state with the new profile image
                  setState(() {
                    widget.user.profileImageUrl = updatedProfileImage;
                  });
                }
              },
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
            rows: expenses
                .map(
                  (expense) => DataRow(
                cells: <DataCell>[
                  DataCell(
                    TextField(
                      decoration: InputDecoration(hintText: "Expense Type"),
                      controller: TextEditingController(text: expense.type),
                      onChanged: (value) {
                        setState(() {
                          expense.type = value;
                        });
                      },
                    ),
                  ),
                  DataCell(
                    TextField(
                      decoration: InputDecoration(hintText: "Amount"),
                      controller: TextEditingController(text: expense.amount),
                      onChanged: (value) {
                        setState(() {
                          expense.amount = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
                .toList(),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Add a new expense row
                expenses.add(Expense("", ""));
                showTotalAmount = false; // Reset the flag when adding a new expense
              });
            },
            child: Text("Add Expense"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Calculate total amount
                totalAmount = calculateTotalAmount();
                showTotalAmount = true; // Set the flag to show the total amount
              });
            },
            child: Text("Calculate Total Expenses"),
          ),
          SizedBox(height: 10),
          if (showTotalAmount)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.green[100],
              child: Center(
                child: Text(
                  "Your efficient budgeting is catching up to you! Your Total Expenses are $totalAmount",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  double calculateTotalAmount() {
    double total = 0.0;
    for (Expense expense in expenses) {
      try {
        total += double.parse(expense.amount);
      } catch (e) {
        // Handle parsing errors if necessary
      }
    }
    return total;
  }
}

class Expense {
  String type;
  String amount;

  Expense(this.type, this.amount);
}
