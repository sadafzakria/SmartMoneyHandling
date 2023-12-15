//NOT USED
class SingleTransaction {
  String transaction_id;
  final TransactionType type;
  final DateTime date;
  final String account_id;
  final double amount;

  SingleTransaction
  ({
    required this.transaction_id,
    required this.type,
    required this.date,
    required this.account_id,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'transaction_id': transaction_id,
    'type' : type.toString(),
    'date': date,
    'account_id': account_id,
    'amount': amount,
  };

  static SingleTransaction fromJson(Map<String, dynamic> json) => SingleTransaction(
    transaction_id: json['transaction_id'],
    type: json['type'],
    date: json['date'],
    account_id: json['account_id'],
    amount: json['amount'],
  );
}

enum TransactionType
{
  entertainment,
  shopping,
  subscriptions,

  savings,
  emergency,
  investment,

  insurance,
  groceries,
  transportation,
  utilities,
  loans
}

