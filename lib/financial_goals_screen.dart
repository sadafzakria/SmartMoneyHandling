import 'package:flutter/material.dart';

class FinancialGoalsScreen extends StatefulWidget {
  final List<bool> initialSelectedGoals;
  final Function(List<bool>) onGoalsUpdated;

  const FinancialGoalsScreen({
    Key? key,
    required this.initialSelectedGoals,
    required this.onGoalsUpdated,
  }) : super(key: key);

  @override
  State<FinancialGoalsScreen> createState() => _FinancialGoalsScreenState();
}

class _FinancialGoalsScreenState extends State<FinancialGoalsScreen> {
  late List<bool> selectedGoals;

  @override
  void initState() {
    super.initState();
    selectedGoals = List.from(widget.initialSelectedGoals);
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
                      value: selectedGoals[0],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[0] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[1],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[1] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[2],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[2] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[3],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[3] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[4],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[4] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[5],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[5] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[6],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[6] = value ?? false;
                        });
                      },
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
                      value: selectedGoals[7],
                      onChanged: (value) {
                        setState(() {
                          selectedGoals[7] = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Financial Goals Updated!')),
                  );
                  widget.onGoalsUpdated(selectedGoals);
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
