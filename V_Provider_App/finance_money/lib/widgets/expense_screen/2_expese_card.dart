// ignore_for_file: body_might_complete_normally_nullable
import 'package:finance_money/constants/icons.dart';
import 'package:finance_money/models/expense_model.dart';
import 'package:finance_money/widgets/expense_screen/1_confirm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Todo: ExpenseCard
class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(expense.id),
      confirmDismiss: (_) async {
        showDialog(
          context: context,
          builder: (_) => ConfirmBox(expense: expense),
        );
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icons[expense.category]),
        ),
        title: Text(expense.title),
        subtitle: Text(DateFormat('MMMM dd, yyyy').format(expense.date)),
        trailing: Text(
          NumberFormat.currency(locale: 'en_IN', symbol: '\$')
              .format(expense.amount),
        ),
      ),
    );
  }
}
