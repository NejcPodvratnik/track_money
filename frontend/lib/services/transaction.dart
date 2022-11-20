import 'dart:convert';

import 'package:http/http.dart' as http;

//Models
import 'package:frontend/models/transaction.dart';

class TransactionAPI {
  static Future<Transaction> create(
    String token,
    double value,
    String paymentMethod,
    String flow,
    String category,
    String description,
  ) async {
    Uri url = Uri.parse("http://localhost:8000/api/transaction");
    var res = await http.post(
      url,
      headers: {
        "authorization": "Bearer $token",
      },
      body: {
        "value": value,
        "paymentMethod": paymentMethod,
        "flow": flow,
        "category": category,
        "description": description,
      },
    );
    if (res.statusCode != 201) {
      throw jsonDecode(res.body)["message"];
    }
    return transactionFromJson(res.body);
  }

  static Future<List<Transaction>> list(
    String token,
    String flow,
    DateTime startDate,
    DateTime endDate,
  ) async {
    Uri url = Uri.parse("http://localhost:8000/api/transaction/list");
    var res = await http.post(
      url,
      headers: {
        "authorization": "Bearer $token",
      },
      body: {
        "startDate": startDate.toIso8601String().substring(0, 10),
        "endDate": endDate.toIso8601String().substring(0, 10),
        "flow": flow,
      },
    );
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)["message"];
    }
    return (jsonDecode(res.body) as List<dynamic>)
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }

  static Future<Transaction> find(
    String token,
    String id,
  ) async {
    Uri url = Uri.parse("http://localhost:8000/api/transaction/$id");
    var res = await http.get(
      url,
      headers: {
        "authorization": "Bearer $token",
      },
    );
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)["message"];
    }
    return transactionFromJson(res.body);
  }

  static Future<Transaction> update(
    String token,
    String id,
    double value,
    String paymentMethod,
    String flow,
    String category,
    String description,
  ) async {
    Uri url = Uri.parse("http://localhost:8000/api/transaction/$id");
    var res = await http.put(
      url,
      headers: {
        "authorization": "Bearer $token",
      },
      body: {
        "value": value,
        "paymentMethod": paymentMethod,
        "flow": flow,
        "category": category,
        "description": description,
      },
    );
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)["message"];
    }
    return transactionFromJson(res.body);
  }

  static Future<Transaction> delete(String token, String id) async {
    Uri url = Uri.parse("http://localhost:8000/api/transaction/$id");
    var res = await http.delete(
      url,
      headers: {
        "authorization": "Bearer $token",
      },
    );
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)["message"];
    } else {
      return transactionFromJson(res.body);
    }
  }
}
