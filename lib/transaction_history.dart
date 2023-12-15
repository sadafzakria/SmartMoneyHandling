import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {

  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  var _transactionHistory = []; // Replace with your actual data structure

  @override
  void initState() {
    // Load transaction history data when the widget is initialized
    _loadTransactionHistory();
    super.initState();
  }

  void _loadTransactionHistory() {
    // Implement logic to fetch transaction history based on userId and accountName
    // Replace the below example with your actual data fetching logic
    _transactionHistory = [
      {'date': '2023-01-01', 'amount': 50.0, 'category': 'Groceries'},
      {'date': '2023-02-15', 'amount': 120.0, 'category': 'Shopping'},
      // Add more transactions as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _transactionHistory.length,
          itemBuilder: (context, index) {
            var transaction = _transactionHistory[index];
            return ListTile(
              title: Text("Date: ${transaction['date']}"),
              subtitle: Text("Amount: \$${transaction['amount']} - Category: ${transaction['category']}"),
              // Add more details as needed
            );
          },
        ),
      ),
    );
  }
}
