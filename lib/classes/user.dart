import 'goals.dart';

class User {
  String id;
  final String fname;
  final String lname;
  final String username;
  final String password;
  String profileImageUrl;
  List<FinancialGoal> goals;

  User({
    this.id = '',
    required this.fname,
    required this.lname,
    required this.username,
    required this.password,
    required this.profileImageUrl,
    List<FinancialGoal>? goals,
  }) : goals = goals ?? [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'fname': fname,
    'lname': lname,
    'username': username,
    'password': password,
    'profileImageUrl': profileImageUrl,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fname: json['fname'],
    lname: json['lname'],
    username: json['username'],
    password: json['password'],
    profileImageUrl: json['profileImageUrl'],
  );
}
