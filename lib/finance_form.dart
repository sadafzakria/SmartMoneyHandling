import 'package:flutter/material.dart';

class FinanceForm extends StatefulWidget {
  const FinanceForm({Key? key});

  @override
  State<FinanceForm> createState() => _FinanceFormState();
}

class _FinanceFormState extends State<FinanceForm> {
  // Initial Selected Values for each question
  List<String> dropdownValues = [
    'Strongly Agree',
    'Strongly Agree',
    'Strongly Agree',
    'Strongly Agree',
    'Strongly Agree',
    'Strongly Agree',
    'Strongly Agree',
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
    'Question 1: How would you rate this?',
    'Question 2: How would you rate that?',
    'Question 3: How would you rate something else?',
    'Question 4: How would you rate another thing?',
    'Question 5: How would you rate yet another thing?',
    'Question 6: How would you rate one more thing?',
    'Question 7: How would you rate the last thing?',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            children: List.generate(7, (index) {
              return Container(
                margin: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(questions[index], style: TextStyle(fontSize: 16)),
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
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {}, // empty for now
            style: ElevatedButton.styleFrom(
              primary: Colors.green[900],
              minimumSize: Size(100, 35),
            ),
          ),
        ],
      ),
    );
  }
}
