class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final String type; // income | expense
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  // Object → JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'type': type,
        'date': date.toIso8601String(),
      };

  // JSON → Object
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      date: DateTime.parse(json['date']),
    );
  }
}
