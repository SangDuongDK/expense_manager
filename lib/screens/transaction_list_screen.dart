import'package:flutter/material.dart';
import '../services/transaction_service.dart';
import '../models/transaction_model.dart';
import 'transaction_form_screen.dart';


class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});


  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}


class _TransactionListScreenState extends State<TransactionListScreen> {
  final service = TransactionService();
  List<TransactionModel> items = [];
  double totalIncome = 0;
  double totalExpense = 0;


  @override
    void initState() {
      super.initState();
      load();
  }

  Future<void> load() async {
    items = await service.getAll();
    totalIncome = await service.totalIncome();
    totalExpense = await service.totalExpense();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Chi tiêu')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TransactionFormScreen()),
          );
          if (!mounted) return;
          load();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Tổng thu'),
              trailing: Text(
                totalIncome.toString(),
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Tổng chi'),
              trailing: Text(
                totalExpense.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Số dư'),
              trailing: Text(
                (totalIncome - totalExpense).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (totalIncome - totalExpense) >= 0
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final t = items[i];
                return ListTile(
                  key: Key('transaction-${t.id}'),
                  title: Text(t.title),
                  subtitle: Text('${t.amount} - ${t.type}'),

                  // BẤM VÀO ĐỂ SỬA
                  onTap: () async {
                    final res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionFormScreen(transaction: t),
                      ),
                    );
                    if (res == true) await load(); // thêm await
                  },

                  trailing: IconButton(
                    key: Key('delete-${t.id}'),
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await service.delete(t.id);
                      load();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}