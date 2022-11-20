import 'package:flutter/material.dart';

class TransactionFilterConfig {
  TransactionFilterConfig(this.flow, this.startDate, this.endDate);

  String flow;
  DateTime startDate;
  DateTime endDate;

  TransactionFilterConfig copyWith({
    String? flow,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TransactionFilterConfig(
      flow ?? this.flow,
      startDate ?? this.startDate,
      endDate ?? this.endDate,
    );
  }
}
