import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_money_handling/classes/account.dart';
import 'transaction_history.dart';
import 'classes/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'classes/user.dart';

class NewTransactionScreen extends StatefulWidget {
  final User user;
  const NewTransactionScreen({super.key, required this.user});

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  DateTime _chosenDate = DateTime.now();
  TextEditingController _amountController = TextEditingController();
  String dropDownValueTransaction = name(TransactionType.entertainment);
  String dropDownValueAccount = name(AccountType.checking);

  var transactionTypes = [
    name(TransactionType.entertainment),
    name(TransactionType.subscriptions),
    name(TransactionType.shopping),

    name(TransactionType.savings),
    name(TransactionType.emergency),
    name(TransactionType.investment),

    name(TransactionType.loans),
    name(TransactionType.groceries),
    name(TransactionType.utilities),
    name(TransactionType.transportation),
  ];

  var userAccounts = []; //
  var accountTypes = [
    name(AccountType.checking),
    name(AccountType.savings),
    name(AccountType.other),
  ];

  @override
  void initState() {
    userAccounts = getAccountNamesForUser(widget.user.id);
    super.initState();
  }
  static String name(dynamic str)
  {
    if (str is TransactionType || str is AccountType)
      return str.toString().split('.').last;

    return '';
  }

  static Future<List<String>> getAccountNamesForUser(String userId) async {
    List<String> accountNames = [];

    try {
      CollectionReference accountsCollection = FirebaseFirestore.instance.collection('accounts');

      QuerySnapshot querySnapshot = await accountsCollection.where('user_id', isEqualTo: userId).get();

      // Iterate through the query snapshot and extract account names
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        // Access the 'name' field of each document
        var accountName = document['name'];
        accountNames.add(accountName);
      });

    } catch (e) {
      print('Error retrieving account names: $e');
    }

    return accountNames;
  }

  /*
  Future<List<DocumentSnapshot>> getAccounts(String user_id) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('account')
          .where('user_id', isEqualTo: user_id)
          .get();

      return querySnapshot.docs;

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error checking username uniqueness: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }*/

  Future<void> createTransaction(SingleTransaction transaction) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('transaction').doc();
      transaction.transaction_id = docUser.id;
      final json = transaction.toJson();
      await docUser.set(json);
      //_formKey.currentState?.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating transaction: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
              SizedBox(
                height: 30,
              ),
              Text(
                'New Transaction',
                style: TextStyle(fontSize: 30),
              ),
              Divider(
                thickness: 2,
                color: Colors.green,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Transaction Category',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
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
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValueTransaction = newValue!;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Transaction Amount',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 40,
                    width: 130,
                    color: Colors.white,
                    child: TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^-?\d*\.?\d*)'))
                      ],
                      controller: _amountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Transaction Date',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
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
                        child: Text('Pick Date...')),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 80,
                  ),
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
                        value: dropDownValueAccount, // TODO: CHANGE TO THE ACCOUNTS OWNED BY USER
                        items: accountTypes.map((String item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValueAccount = newValue!;
                          });
                        }),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    // TODO: FETCH ACCOUNT AMOUNT AND EVALUATE IF THERES ENOUGH

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Transaction Registered!')));
                  },
                  child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
