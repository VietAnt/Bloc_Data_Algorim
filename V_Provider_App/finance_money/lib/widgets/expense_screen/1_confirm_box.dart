import 'package:finance_money/database/database_provider.dart';
import 'package:finance_money/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: ConfirmBox
class ConfirmBox extends StatelessWidget {
  final Expense expense;

  const ConfirmBox({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);

    return AlertDialog(
      title: Text('Delete ${expense.title} ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Don\'t delete'),
          ),
          const SizedBox(width: 5.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              provider.deleteExpense(
                expense.id,
                expense.category,
                expense.amount,
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
