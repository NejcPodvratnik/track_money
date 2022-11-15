import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    required this.date,
    required this.owner,
    required this.value,
    required this.paymentMethod,
    required this.flow,
    required this.category,
    required this.description,
    required this.id,
  });

  final DateTime date;
  final String owner;
  final double value;
  final String paymentMethod;
  final String flow;
  final String category;
  final String description;
  final String id;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        date: DateTime.parse(json["date"]),
        owner: json["owner"],
        value: json["value"],
        paymentMethod: json["paymentMethod"],
        flow: json["flow"],
        category: json["category"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "owner": owner,
        "value": value,
        "paymentMethod": paymentMethod,
        "flow": flow,
        "category": category,
        "description": description,
        "id": id,
      };
}
