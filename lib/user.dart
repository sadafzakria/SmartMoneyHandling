import 'goals.dart';

class User {
  String id;
  final String fname;
  final String lname;
  final String username;
  final String password;
  List<FinancialGoal> goals;

  User({
    this.id = '',
    required this.fname,
    required this.lname,
    required this.username,
    required this.password,
    List<FinancialGoal>? goals, // Allow null for default
  }) : goals = goals ?? [];
  // remove goals its an attempt at incorporating outside fields into the firebase db

  Map<String, dynamic> toJson() => {
        'id': id,
        'fname': fname,
        'lname': lname,
        'username': username,
        'password': password,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        fname: json['fname'],
        lname: json['lname'],
        username: json['username'],
        password: json['password'],
      );
}
