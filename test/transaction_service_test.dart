import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_manager/models/transaction_model.dart';
import 'package:expense_manager/services/transaction_service.dart';

void main() {
  late TransactionService service;

  setUp(() async {
    // Reset SharedPreferences trước mỗi test
    SharedPreferences.setMockInitialValues({});
    service = TransactionService();
  });

  test('Thêm giao dịch mới', () async {
    final t = TransactionModel(
      id: '1',
      title: 'Tiền lương',
      amount: 1000,
      type: 'income',
      date: DateTime.now(),
    );

    await service.add(t);
    final list = await service.getAll();
    expect(list.length, 1);
    expect(list[0].title, 'Tiền lương');
  });

  test('Cập nhật giao dịch', () async {
    final t = TransactionModel(
      id: '1',
      title: 'Tiền lương',
      amount: 1000,
      type: 'income',
      date: DateTime.now(),
    );
    await service.add(t);

    final updated = TransactionModel(
      id: '1',
      title: 'Tiền lương cập nhật',
      amount: 1200,
      type: 'income',
      date: DateTime.now(),
    );

    await service.update(updated);
    final list = await service.getAll();
    expect(list[0].title, 'Tiền lương cập nhật');
    expect(list[0].amount, 1200);
  });

  test('Xóa giao dịch', () async {
    final t = TransactionModel(
      id: '1',
      title: 'Tiền lương',
      amount: 1000,
      type: 'income',
      date: DateTime.now(),
    );
    await service.add(t);
    await service.delete('1');

    final list = await service.getAll();
    expect(list.isEmpty, true);
  });

  test('Tính tổng thu và tổng chi', () async {
    final t1 = TransactionModel(
      id: '1',
      title: 'Tiền lương',
      amount: 1000,
      type: 'income',
      date: DateTime.now(),
    );
    final t2 = TransactionModel(
      id: '2',
      title: 'Mua sắm',
      amount: 400,
      type: 'expense',
      date: DateTime.now(),
    );
    await service.add(t1);
    await service.add(t2);

    final income = await service.totalIncome();
    final expense = await service.totalExpense();

    expect(income, 1000);
    expect(expense, 400);
  });
}
