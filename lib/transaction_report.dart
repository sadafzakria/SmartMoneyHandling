//scrapped off screen
import 'package:flutter/material.dart';

class TransactionReport extends StatefulWidget {
  const TransactionReport({super.key});

  @override
  State<TransactionReport> createState() => _TransactionReportState();
}

class _TransactionReportState extends State<TransactionReport> {
  String? _description =
      "You're doing great! You've spent a total of \$XXXX.XX this month, this is 5.21% better than last month's spending.";
  String _expense_details =
      "Detailed explanation here on each type of \nexpense: ............................................................................................................................................................................................";

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Text(
              "Current Transaction Report",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
            thickness: 2.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "$_description",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "$_expense_details",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(16.0),
            child: Table(
              border: TableBorder.all(),
              children: [
                _buildTableRow(['Type', 'Amount', 'Date', 'Goal'],
                    isHeader: true),
                _buildTableRow(['Grocery', '\$87.65', '9/28/2022', '\$100.00']),
                _buildTableRow(
                    ['Housing', '\$1050.00', '9/30/2022', '\$1050.00']),
                _buildTableRow(['Travel', '\$200.00', '10/1/2022', '\$200.00']),
                _buildTableRow(['Dining', '\$65.00', '10/5/2022', '\$80.00']),
                _buildTableRow(
                    ['Transportation', '\$95.00', '10/23/2022', '\$100.00']),
              ],
            ),
          ),
        ],
    );
  }
}

TableRow _buildTableRow(List<String> data, {bool isHeader = false}) {
  final style = TextStyle(
      fontSize: 12, fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
  return TableRow(
    children: data
        .map((item) => TableCell(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(item, style: style),
                ),
              ),
            ))
        .toList(),
  );
}
