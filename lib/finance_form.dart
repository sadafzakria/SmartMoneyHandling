import 'package:flutter/material.dart';

class FinanceForm extends StatefulWidget {
  const FinanceForm({Key? key});

  @override
  State<FinanceForm> createState() => _FinanceFormState();
}

class _FinanceFormState extends State<FinanceForm> {
  // Initial Selected Values for each question
  List<String> dropdownValues = [
    'Strongly Agree', // 1
    'Strongly Agree', // 2
    'Strongly Agree', // 3
    'Strongly Agree', // 4
    'Strongly Agree', // 5
    'Strongly Agree', // 6
    'Strongly Agree', // 7
    'Strongly Agree', // 8
    'Strongly Agree', // 9
    'Strongly Agree', // 10
    'Strongly Agree', // 11
    'Strongly Agree', // 12
    'Strongly Agree', // 13
    'Strongly Agree', // 14
    'Strongly Agree', // 15

  ];

  // Likert Scale
  var items = [
    'Strongly Agree',
    'Agree',
    'Neither',
    'Disagree',
    'Strongly Disagree',
  ];

  // List of questions
  var questions = [
     // HOUSING
    '1. I prioritize owning a home as part of my long-term financial goals.',
    '2. Investing in real estate is important to me for building wealth.',
    '3. I am willing to make sacrifices in other areas to afford a house.',
    // LIVING EXPENSES
    '4. Maintaining a comfortable lifestyle is a top financial priority for me.',
    '5. I am willing to cut down on discretionary spending to save for the future.',
    '6. I prioritize experiences over material possessions in my budget.',
    // TRANSPORTATION
    '7. Owning a car is essential to my lifestyle and financial goals.',
    '8. I am open to using public transportation to reduce transportation costs.',
    '9. I prioritize fuel-efficient and eco-friendly transportation options.',
    // SAVINGS AND INVESTMENTS
    '10. Building a substantial emergency fund is a key part of my financial strategy.',
    '11. I am comfortable with moderate to high-risk investments for potential higher returns.',
    '12. Consistently saving a percentage of my income is a financial goal for me.',
    // DEBT MANAGEMENT
    '13. I am comfortable taking on debt for significant purchases, like education or a home.',
    '14. Reducing and eliminating debt is a top priority in my financial plan.',
    '15. I am cautious about taking on new debt, even for major life expenses.',
  ];

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
                return Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(questions[index],
                            style: TextStyle(fontSize: 16)),
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

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Financial Chart Updated!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[900],
                minimumSize: Size(100, 35),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
