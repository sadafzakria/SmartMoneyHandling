import 'package:flutter/material.dart';
import 'package:smart_money_handling/new_transaction_screen.dart';
import 'classes/data.dart';

class MyAccountsScreen extends StatefulWidget {
  const MyAccountsScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountsScreen> createState() => _MyAccountsScreenState();
}

class _MyAccountsScreenState extends State<MyAccountsScreen> {
  List<TransactionData> transactions = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 30),
            ),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            for (int index = 0; index < transactions.length; index++)
              _buildTransactionDetails(transactions[index], index),
            IconButton(
              onPressed: () async {
                TransactionData? result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewTransactionScreen(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    transactions.add(result);
                  });
                }
              },
              icon: Icon(Icons.add, size: 60, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetails(TransactionData transaction, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: Icon(Icons.attach_money, size: 36, color: Colors.green),
          title: Text(
            transaction.accountType,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('Category: ${transaction.category}',
                  style: TextStyle(fontSize: 16)),
              Text('Amount: \$${transaction.amount}',
                  style: TextStyle(fontSize: 16)),
              Text('Date: ${transaction.date}',
                  style: TextStyle(fontSize: 16)),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteTransaction(index);
            },
          ),
        ),
      ),
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }
}
