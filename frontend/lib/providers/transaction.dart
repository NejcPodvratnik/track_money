import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Models
import 'package:frontend/models/transaction.dart';
import 'package:frontend/models/transaction_filter_config.dart';

//Services
import 'package:frontend/services/transaction.dart';

//Utils
import 'package:frontend/utils/show_info_snackbar.dart';

class TransactionsNotifier
    extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionsNotifier(this.token, AsyncValue<List<Transaction>> transactions)
      : super(transactions);

  String token;

  Future<void> create(
    BuildContext context,
    double value,
    String paymentMethod,
    String flow,
    String category,
    String description,
  ) async {
    state.whenData((transactions) {
      TransactionAPI.create(
              token, value, paymentMethod, flow, category, description)
          .then((transaction) {
        state = AsyncData([...transactions, transaction]);
      }).catchError((err) {
        showInfoSnackBar(context, err);
      });
    });
  }

  Future<void> update(
    BuildContext context,
    String id,
    double value,
    String paymentMethod,
    String flow,
    String category,
    String description,
  ) async {
    state.whenData((transactions) {
      TransactionAPI.update(
              id, token, value, paymentMethod, flow, category, description)
          .then((transaction) {
        state = AsyncData([
          for (final q in transactions)
            if (q.id == id) transaction else q,
        ]);
      }).catchError((err) {
        showInfoSnackBar(context, err);
      });
    });
  }

  Future<void> delete(String id) async {
    state.whenData((transactions) {
      TransactionAPI.delete(token, id).whenComplete(() => state = AsyncData(
          transactions.where((transaction) => transaction.id != id).toList()));
    });
  }
}

final transactionsStateNotifierProvider = StateNotifierProvider.family<
    TransactionsNotifier, AsyncValue<List<Transaction>>, String>((ref, token) {
  final AsyncValue<List<Transaction>> transactions =
      ref.watch(transactionsProvider(token));

  return TransactionsNotifier(token, transactions);
});

final transactionsProvider =
    FutureProvider.family<List<Transaction>, String>(((ref, token) async {
  final TransactionFilterConfig config =
      ref.watch(transactionFilterConfigProvider);

  return await TransactionAPI.list(
      token, config.flow, config.startDate, config.endDate);
}));

final transactionFilterConfigProvider = StateProvider<TransactionFilterConfig>(
    ((ref) => TransactionFilterConfig(
        "all", DateTime.parse("2022-10-01"), DateTime.now())));
