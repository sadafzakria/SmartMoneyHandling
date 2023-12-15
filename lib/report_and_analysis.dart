import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'financial_goals_screen.dart';

class ReportAndAnalysis extends StatefulWidget {
  const ReportAndAnalysis({super.key});

  @override
  State<ReportAndAnalysis> createState() => _ReportAndAnalysisState();
}

class _ReportAndAnalysisState extends State<ReportAndAnalysis> {
  List<bool> selectedGoals = List.filled(8, false);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.3,
          child: PieChart(
            PieChartData(
              sections: _generatePieChartSections(),
              centerSpaceRadius: 40,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: _buildReportAnalysis(),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FinancialGoalsScreen(
                  initialSelectedGoals: selectedGoals,
                  onGoalsUpdated: (updatedGoals) {
                    setState(() {
                      selectedGoals = updatedGoals;
                    });
                  },
                ),
              ),
            );
          },
          child: Text('Set Your Financial Goals'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900],
            minimumSize: Size(50, 35),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FinancialGoalsScreen(
                  initialSelectedGoals: selectedGoals,
                  onGoalsUpdated: (updatedGoals) {
                    setState(() {
                      selectedGoals = updatedGoals;
                    });
                  },
                ),
              ),
            );
          },
          child: Text('Explore Your Financial Mindset'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900],
            minimumSize: Size(50, 35),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generatePieChartSections() {
    final List<Color> legendColors = [
      Colors.pinkAccent,
      Colors.green,
      Colors.deepOrangeAccent,
      Colors.brown,
      Colors.cyan,
    ];

    final List<String> goalTitles = [
      'Housing',
      'Living Expenses',
      'Transportation',
      'Savings/Investments',
      'Debt',
    ];

    final List<double> goalValues = [37.9, 15.5, 4.2, 4.9, 36.9];

    return List.generate(goalTitles.length, (index) {
      final isSelected = selectedGoals[index];
      final color = isSelected ? legendColors[index] : Colors.grey;

      return PieChartSectionData(
        color: color,
        value: isSelected ? goalValues[index] : 0,
        title: isSelected ? '${goalValues[index]}' : '',
        radius: 100.0,
      );
    });
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

  Widget _buildReportAnalysis() {
    final selectedGoalTitles = [
      'Being Debt Free',
      'Building an Emergency Fund',
      'Travelling More',
      'Investing',
      'Being More Resourceful',
      'Saving for Retirement',
      'Buying a Home',
      'Budgeting Better',
    ];

    final selectedGoalsList =
    List.generate(selectedGoals.length, (index) {
      if (selectedGoals[index]) {
        return selectedGoalTitles[index];
      } else {
        return null;
      }
    });

    return Text(
      selectedGoalsList.where((goal) => goal != null).isNotEmpty
          ? "Selected financial goals: ${selectedGoalsList.where((goal) => goal != null).join(', ')}"
          : "You haven't set your financial goals yet",
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}
