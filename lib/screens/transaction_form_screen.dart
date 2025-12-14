import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionFormScreen extends StatefulWidget {
  final TransactionModel? transaction;
  final String? forceId; // thêm

  const TransactionFormScreen({
    super.key,
    this.transaction,
    this.forceId,
  });

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final titleCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  String type = 'expense';

  final service = TransactionService();

  @override
  void initState() {
    super.initState();

    // nếu là sửa → đổ dữ liệu cũ lên form
    if (widget.transaction != null) {
      titleCtrl.text = widget.transaction!.title;
      amountCtrl.text = widget.transaction!.amount.toString();
      type = widget.transaction!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.transaction != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Sửa giao dịch' : 'Thêm giao dịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: amountCtrl,
              decoration: const InputDecoration(labelText: 'Số tiền'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: type,
              items: const [
                DropdownMenuItem(value: 'income', child: Text('Thu')),
                DropdownMenuItem(value: 'expense', child: Text('Chi')),
              ],
              onChanged: (v) => setState(() => type = v!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final t = TransactionModel(
                  id: widget.transaction != null
                      ? widget.transaction!.id
                      : (widget.forceId ?? const Uuid().v4()), // dùng forceId nếu có
                  title: titleCtrl.text,
                  amount: double.parse(amountCtrl.text),
                  type: type,
                  date: DateTime.now(),
                );

                if (isEdit) {
                  await service.update(t);
                } else {
                  await service.add(t);
                }

                if (!context.mounted) return;
                Navigator.pop(context, true);
              },
              child: Text(isEdit ? 'Cập nhật' : 'Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}
