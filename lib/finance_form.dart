import 'package:flutter/material.dart';

class FinanceForm extends StatefulWidget {
  const FinanceForm({Key? key});

  static double housingPoints = 0;
  static double livingExpensesPoints = 0;
  static double transportationPoints = 0;
  static double savingsInvestmentsPoints = 0;
  static double debtPoints = 0;

  @override
  State<FinanceForm> createState() => _FinanceFormState();
}

class _FinanceFormState extends State<FinanceForm> {
  // Initial Selected Values for each question
  List<String> dropdownValues = List.filled(15, 'Strongly Agree');

  // Likert Scale
  var items = [
    'Strongly Agree', // 5 pts
    'Agree', // 4 pts
    'Neither', // 3 pts
    'Disagree', // 2 pts
    'Strongly Disagree', // 1pts
  ];

  // Map questions to categories
  var questions = {
    'Housing': [
      'I prioritize owning a home as part of my long-term financial goals.',
      'Investing in real estate is important to me for building wealth.',
      'I am willing to make sacrifices in other areas to afford a house.',
    ],
    'Living Expenses': [
      'Maintaining a comfortable lifestyle is a top financial priority for me.',
      'I am willing to cut down on discretionary spending to save for the future.',
      'I prioritize experiences over material possessions in my budget.',
    ],
    'Transportation': [
      'Owning a car is essential to my lifestyle and financial goals.',
      'I am open to using public transportation to reduce transportation costs.',
      'I prioritize fuel-efficient and eco-friendly transportation options.',
    ],
    'Savings/Investments': [
      'Building a substantial emergency fund is a key part of my financial strategy.',
      'I am comfortable with moderate to high-risk investments for potential higher returns.',
      'Consistently saving a percentage of my income is a financial goal for me.',
    ],
    'Debt': [
      'I am comfortable taking on debt for significant purchases, like education or a home.',
      'Reducing and eliminating debt is a top priority in my financial plan.',
      'I am cautious about taking on new debt, even for major life expenses.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                "Help Us Understand Your Financial Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              indent: 16.0,
              endIndent: 16.0,
              thickness: 2.0,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(15, (index) {
                String category = getCategoryForIndex(index);
                String question = questions[category]![index % 3];
                return Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(question, style: TextStyle(fontSize: 16)),
                      ),
                      Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value: dropdownValues[index],
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: items.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              // Update selected value
                              dropdownValues[index] = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            ElevatedButton(
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // Reset points before updating
                resetPoints();

                // Update category points based on user responses
                updateCategoryPoints();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Financial Chart Updated!')),
                );

                // Normalize points to a scale of 0 to 100
                double maxPossiblePoints = 60;
                normalizePoints(maxPossiblePoints);

                Navigator.pop(
                    context, true); // Pass back a flag indicating success
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reset points to zero
  void resetPoints() {
    FinanceForm.housingPoints = 0;
    FinanceForm.livingExpensesPoints = 0;
    FinanceForm.transportationPoints = 0;
    FinanceForm.savingsInvestmentsPoints = 0;
    FinanceForm.debtPoints = 0;
  }

  // Update category points based on the selected values
  void updateCategoryPoints() {
    for (int i = 0; i < 15; i++) {
      String category = getCategoryForIndex(i);
      double points = calculatePointsForAnswer(dropdownValues[i]);
      updatePointsForCategory(category, points);
    }
  }

  // Get category based on the question index
  String getCategoryForIndex(int index) {
    if (index < 3) {
      return 'Housing';
    } else if (index < 6) {
      return 'Living Expenses';
    } else if (index < 9) {
      return 'Transportation';
    } else if (index < 12) {
      return 'Savings/Investments';
    } else {
      return 'Debt';
    }
  }

  // Calculate points based on the selected answer
  double calculatePointsForAnswer(String answer) {
    switch (answer) {
      case 'Strongly Agree':
        return 5;
      case 'Agree':
        return 4;
      case 'Neither':
        return 3;
      case 'Disagree':
        return 2;
      case 'Strongly Disagree':
        return 1;
      default:
        return 0;
    }
  }

  // Update points for each category
  void updatePointsForCategory(String category, double points) {
    switch (category) {
      case 'Housing':
        FinanceForm.housingPoints += points;
        break;
      case 'Living Expenses':
        FinanceForm.livingExpensesPoints += points;
        break;
      case 'Transportation':
        FinanceForm.transportationPoints += points;
        break;
      case 'Savings/Investments':
        FinanceForm.savingsInvestmentsPoints += points;
        break;
      case 'Debt':
        FinanceForm.debtPoints += points;
        break;
    }
  }

  // Normalize points to a scale of 0 to 100
  void normalizePoints(double maxPossiblePoints) {
    FinanceForm.housingPoints =
        (FinanceForm.housingPoints / maxPossiblePoints) * 100;
    FinanceForm.livingExpensesPoints =
        (FinanceForm.livingExpensesPoints / maxPossiblePoints) * 100;
    FinanceForm.transportationPoints =
        (FinanceForm.transportationPoints / maxPossiblePoints) * 100;
    FinanceForm.savingsInvestmentsPoints =
        (FinanceForm.savingsInvestmentsPoints / maxPossiblePoints) * 100;
    FinanceForm.debtPoints = (FinanceForm.debtPoints / maxPossiblePoints) * 100;
  }
}
