import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'classes/account.dart';
import 'classes/transaction.dart';
import 'classes/data.dart';
import 'classes/notification_service.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({Key? key}) : super(key: key);

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  late NotificationService notificationService; // Declare NotificationService
  TextEditingController _amountController = TextEditingController();
  DateTime _chosenDate = DateTime.now();
  String dropDownValueTransaction = name(TransactionType.entertainment);
  String dropDownValueAccount = name(AccountType.checking);

  // List of transaction types
  var transactionTypes = [
    name(TransactionType.entertainment),
    name(TransactionType.subscriptions),
    name(TransactionType.shopping),
    name(TransactionType.savings),
    name(TransactionType.emergency),
    name(TransactionType.investment),
    name(TransactionType.insurance),
    name(TransactionType.groceries),
    name(TransactionType.transportation),
    name(TransactionType.utilities),
    name(TransactionType.loans),
  ];

  var accountTypes = [
    name(AccountType.checking),
    name(AccountType.savings),
    name(AccountType.other),
  ];

  static String name(dynamic str) {
    if (str is TransactionType || str is AccountType) {
      return str.toString().split('.').last;
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    notificationService = NotificationService(); // Initialize NotificationService
  }

  Future<void> _showNotification(String title, String body) async {
    await notificationService.showNotification(title, body); // Use NotificationService method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'New Transaction',
                style: TextStyle(fontSize: 30),
              ),
              Divider(thickness: 2, color: Colors.green),
              SizedBox(height: 20),
              _buildTransactionCategoryDropdown(),
              SizedBox(height: 20),
              _buildTransactionAmountInput(),
              SizedBox(height: 20),
              _buildTransactionDateButton(),
              SizedBox(height: 20),
              _buildAccountDropdown(),
              ElevatedButton(
                onPressed: () async => await _saveTransaction(),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCategoryDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Transaction Category', style: TextStyle(fontSize: 20)),
        SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: BorderRadius.circular(3),
          ),
          height: 40,
          width: 130,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: DropdownButton(
            underline: Container(),
            dropdownColor: Colors.green,
            style: TextStyle(color: Colors.white),
            value: dropDownValueTransaction,
            items: transactionTypes.map((String item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropDownValueTransaction = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionAmountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Transaction Amount', style: TextStyle(fontSize: 20)),
        SizedBox(width: 20),
        Container(
          height: 40,
          width: 130,
          color: Colors.white,
          child: TextField(
            keyboardType:
            TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            controller: _amountController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDateButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Transaction Date', style: TextStyle(fontSize: 20)),
        SizedBox(width: 20),
        Container(
          height: 40,
          width: 120,
          child: ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2024),
              ).then((value) {
                setState(() {
                  _chosenDate = value!;
                });
              });
            },
            child: Text('Pick Date...'),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Account', style: TextStyle(fontSize: 20)),
        SizedBox(width: 80),
        Container(
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: BorderRadius.circular(3),
          ),
          height: 40,
          width: 130,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: DropdownButton(
            underline: Container(),
            dropdownColor: Colors.green,
            style: TextStyle(color: Colors.white),
            value: dropDownValueAccount,
            items: accountTypes.map((String item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropDownValueAccount = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> _saveTransaction() async {
    // Retrieve information from the form
    String transactionCategory = dropDownValueTransaction;
    double transactionAmount = double.parse(_amountController.text);
    DateTime transactionDate = _chosenDate;
    String accountType = dropDownValueAccount;

    // Create a TransactionData object
    TransactionData newTransaction = TransactionData(
      category: transactionCategory,
      amount: transactionAmount,
      date: transactionDate,
      accountType: accountType,
    );

    // Send the new transaction data back to the previous screen
    Navigator.of(context).pop(newTransaction);

    // Check if the transaction amount is over 500
    if (transactionAmount > 500) {
      // Show a notification alert
      print('Transaction amount exceeds budget!'); // DEBUG
      await _showNotification('Alert', 'Transaction amount exceeds budget!');
    }

  }
}
