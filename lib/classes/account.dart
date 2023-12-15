import 'goals.dart';

class Account {
  final String account_id;
  final AccountType type;
  final double amount;
  final String user_id;

  Account
  ({
      required this.account_id,
      required this.type,
      required this.amount,
      required this.user_id,
  });

  Map<String, dynamic> toJson() => {
    'account_id': account_id,
    'type': type.toString(),
    'amount': amount,
    'user_id': user_id,
  };

  static Account fromJson(Map<String, dynamic> json) => Account(
    account_id: json['account_id'],
    type: json['type'],
    amount: json['amount'],
    user_id: json['user_id'],
  );
}

enum AccountType
{
  checking,
  savings,
  other
}

