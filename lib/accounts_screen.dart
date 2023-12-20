import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:smart_money_handling/new_transaction_screen.dart';
import 'classes/data.dart';


class MyAccountsScreen extends StatefulWidget {
  const MyAccountsScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountsScreen> createState() => _MyAccountsScreenState();
}

class _MyAccountsScreenState extends State<MyAccountsScreen> {
  List<TransactionData> transactions = [];

  triggerNotification(){
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Smart Money Handling',
        body: 'Careful! You are spending an insane amount!',
        //bigPicture: 'asset://assets/images/smh.png',
        //notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

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
                  _checkBudgetExceeded(result.amount);

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
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
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
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  void _checkBudgetExceeded(double amount) {
    if (amount > 500) {
      triggerNotification();
    }
  }
}
