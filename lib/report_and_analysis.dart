import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'financial_goals_screen.dart';
import 'finance_form.dart';

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

            if (result != null) {
              // Handle the result if needed
              print('Received updated goals: $result');
            }
          },
          child: Text('Set Your Financial Goals'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900],
            minimumSize: Size(50, 35),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FinanceForm(),
              ),
            );

            if (result != null) {
              // Handle the result if needed
              print('Received result from FinanceForm: $result');
              // Trigger a rebuild of the ReportAndAnalysis widget if needed
              setState(() {});
            }
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

    bool anyGoalSelected = selectedGoals.any((isSelected) => isSelected);

    // Check if any goal is selected, if not, return an empty list
    if (!anyGoalSelected) {
      return [];
    }

    // Calculate the total points for the default case (no goals selected)
    double totalDefaultPoints = 0.0;

    for (int index = 0; index < goalTitles.length; index++) {
      final isSelected = selectedGoals[index];
      if (isSelected) {
        totalDefaultPoints += getFinanceFormPoints(goalTitles[index]);
      }
    }

    List<PieChartSectionData> sections = [];
    for (int index = 0; index < goalTitles.length; index++) {
      final color = legendColors[index];
      double value = getFinanceFormPoints(goalTitles[index]);

      // Add the section regardless of whether the corresponding goal is selected
      sections.add(PieChartSectionData(
        color: color,
        value: value,
        title: '$value%',
        radius: 100.0,
      ));
    }
    return sections;
  }

  // Helper function to get category points from FinanceForm
  double getFinanceFormPoints(String category) {
    switch (category) {
      case 'Housing':
        return FinanceForm.housingPoints;
      case 'Living Expenses':
        return FinanceForm.livingExpensesPoints;
      case 'Transportation':
        return FinanceForm.transportationPoints;
      case 'Savings/Investments':
        return FinanceForm.savingsInvestmentsPoints;
      case 'Debt':
        return FinanceForm.debtPoints;
      default:
        return 0;
    }
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
          ? "My Goals:\n${selectedGoalsList.where((goal) => goal != null).join(', ')}"
          : "You haven't set your financial goals yet",
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}