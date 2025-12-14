import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_manager/screens/transaction_list_screen.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Thêm giao dịch mới', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionListScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Tiền lương');
    await tester.enterText(find.byType(TextField).at(1), '1000');
    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();

    // Chỉ kiểm tra text hiển thị, không check key
    expect(find.text('Tiền lương'), findsOneWidget);
  });

  testWidgets('Sửa giao dịch', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionListScreen()));
    await tester.pumpAndSettle();

    // Thêm giao dịch trước
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Tiền lương');
    await tester.enterText(find.byType(TextField).at(1), '1000');
    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();

    // Bấm vào giao dịch đầu tiên để sửa
    await tester.tap(find.text('Tiền lương'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Tiền lương cập nhật');
    await tester.enterText(find.byType(TextField).at(1), '1200');
    await tester.tap(find.text('Cập nhật'));
    await tester.pumpAndSettle();

    expect(find.text('Tiền lương cập nhật'), findsOneWidget);
    expect(find.text('Tiền lương'), findsNothing);
  });

  testWidgets('Xóa giao dịch', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionListScreen()));
    await tester.pumpAndSettle();

    // Thêm giao dịch trước
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Tiền lương');
    await tester.enterText(find.byType(TextField).at(1), '1000');
    await tester.tap(find.text('Lưu'));
    await tester.pumpAndSettle();

    // Xóa giao dịch đầu tiên
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('Tiền lương'), findsNothing);
  });
}
