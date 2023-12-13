import 'package:flutter/material.dart';

class FinancialGoalsScreen extends StatefulWidget {
  const FinancialGoalsScreen({super.key});

  @override
  State<FinancialGoalsScreen> createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Money Handling"),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.lightGreen[100],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text('What are your financial goals?', style: TextStyle(fontSize: 25),),
              Divider(
                thickness: 2,
                color: Colors.green,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Being Debt Free', style: TextStyle(fontSize: 13),),
                        value: true,
                        onChanged: (value){}
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Building an emergency fund', style: TextStyle(fontSize: 13),),
                        value: false,
                        onChanged: (value){}
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Travelling more', style: TextStyle(fontSize: 13),),
                        value: true,
                        onChanged: (value){}
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Investing', style: TextStyle(fontSize: 13),),
                        value: false,
                        onChanged: (value){}
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Being more resourceful', style: TextStyle(fontSize: 13),),
                        value: true,
                        onChanged: (value){}
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Saving for retirement', style: TextStyle(fontSize: 13),),
                        value: false,
                        onChanged: (value){}
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Buying a home', style: TextStyle(fontSize: 13),),
                        value: false,
                        onChanged: (value){}
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CheckboxListTile(
                        title: Text('Budgeting better', style: TextStyle(fontSize: 13),),
                        value: true,
                        onChanged: (value){}
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Financial Goals Updated!')));
                  },
                  child: Text('Submit')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'goals.dart';

class FinancialGoalsScreen extends StatefulWidget {
  final List<FinancialGoal> selectedGoals;

  const FinancialGoalsScreen({Key? key, required this.selectedGoals})
      : super(key: key);

  @override
  State<FinancialGoalsScreen> createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {
  bool? isSelected;
  bool beingDebtFree = false;
  bool buildingEmergencyFund = false;
  bool travellingMore = false;
  bool investing = false;
  bool beingResourceful = false;
  bool savingForRetirement = false;
  bool buyingHome = false;
  bool budgetingBetter = false;

  @override
  void initState() {
    super.initState();
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
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text('What are your financial goals?',
                  style: TextStyle(fontSize: 25)),
              Divider(
                thickness: 2,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              for (var goal in widget.selectedGoals)
                _buildCheckboxRow(goal),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    widget.selectedGoals.map((goal) {
                      switch (goal.title) {
                        case 'Being Debt-Free':
                          return goal.copyWith(isSelected: beingDebtFree);
                        case 'Building an emergency fund':
                          return goal.copyWith(
                              isSelected: buildingEmergencyFund);
                        case 'Travelling more':
                          return goal.copyWith(isSelected: travellingMore);
                        case 'Investing':
                          return goal.copyWith(isSelected: investing);
                        case 'Being more resourceful':
                          return goal.copyWith(isSelected: beingResourceful);
                        case 'Saving for retirement':
                          return goal.copyWith(isSelected: savingForRetirement);
                        case 'Buying a home':
                          return goal.copyWith(isSelected: buyingHome);
                        case 'Budgeting better':
                          return goal.copyWith(isSelected: budgetingBetter);
                        default:
                          return goal;
                      }
                    }).toList(),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Financial Goals Updated!')),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(FinancialGoal goal) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CheckboxListTile(
              title: Text(goal.title, style: TextStyle(fontSize: 13)),
              value: goal.isSelected,
              onChanged: (value) {
                setState(() {
                  goal.isSelected = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
        ],
      ),
    );
  }
}
*/