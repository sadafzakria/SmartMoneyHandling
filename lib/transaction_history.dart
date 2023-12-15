import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_money_handling/home_screen.dart';
import 'package:smart_money_handling/report_and_analysis.dart';
import 'package:smart_money_handling/transaction_report.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key, required String id});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {

  var _account_info = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
      ),
      body: Center(

      ),
    );
  }
}
