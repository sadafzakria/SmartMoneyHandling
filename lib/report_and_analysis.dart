import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_money_handling/financial_goals_screen.dart';

class ReportAndAnalysis extends StatefulWidget {
  const ReportAndAnalysis({super.key});


  @override
  State<ReportAndAnalysis> createState() => _ReportAndAnalysisState();
}

class _ReportAndAnalysisState extends State<ReportAndAnalysis> {

  String _report_analysis= "Generate\nFinancial\nGoals\nHere";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height:20),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.pinkAccent,
                  value: 37.9,
                  title: '37.9', // Housing
                  radius: 100.0,
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: 15.5,
                  title: '15.5', //Living Expenses
                  radius: 100.0,
                ),
                PieChartSectionData(
                  color: Colors.deepOrangeAccent,
                  value: 4.2,
                  title: '4.2', // Transportation
                  radius: 100.0,
                ),
                PieChartSectionData(
                  color: Colors.brown,
                  value: 4.9,
                  title: '4.9', // Savings/Investment
                  radius: 100.0,
                ),
                PieChartSectionData(
                  color: Colors.cyan,
                  value: 36.9,
                  title: '36.9', // Debt
                  radius: 100.0,
                ),
              ],
              centerSpaceRadius: 40,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align the legend items to the left
                children: [
                  Text(
                    "Legend",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  _legendItem(Colors.pinkAccent, 'Housing'),
                  _legendItem(Colors.green, 'Living Expenses'),
                  _legendItem(Colors.deepOrangeAccent, 'Transportation'),
                  _legendItem(Colors.brown, 'Savings/Investments'),
                  _legendItem(Colors.cyan, 'Debt'),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "$_report_analysis",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FinancialGoalsScreen()));
          },
          child: Text('Set New Financial Goals'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900],
            minimumSize: Size(50, 35),
          ),
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
          margin: EdgeInsets.all(5),
        ),
        SizedBox(width: 10),
        Text('$title'),
      ],
    );
  }
}
