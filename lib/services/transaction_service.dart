import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionService {
  static const _key = 'transactions';

  Future<List<TransactionModel>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];

    final List data = jsonDecode(raw);
    return data.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<void> _save(List<TransactionModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _key,
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> add(TransactionModel t) async {
    final list = await getAll();
    list.add(t);
    await _save(list);
  }

  Future<void> update(TransactionModel t) async {
    final list = await getAll();
    final index = list.indexWhere((e) => e.id == t.id);
    if (index != -1) {
      list[index] = t;
      await _save(list);
    }
  }

  Future<void> delete(String id) async {
    final list = await getAll();
    list.removeWhere((e) => e.id == id);
    await _save(list);
  }

  // TỔNG THU
  Future<double> totalIncome() async {
    final list = await getAll();
    return list
        .where((e) => e.type == 'income')
        .fold<double>(0.0, (s, e) => s + e.amount);
  }

  // TỔNG CHI
  Future<double> totalExpense() async {
    final list = await getAll();
    return list
        .where((e) => e.type == 'expense')
        .fold<double>(0.0, (s, e) => s + e.amount);
  }
}
