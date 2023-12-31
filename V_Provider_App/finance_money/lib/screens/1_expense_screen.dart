import 'package:finance_money/widgets/expense_screen/5_expense_fetcher.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = '/expense_screen';
  @override
  Widget build(BuildContext context) {
    // get the argument passed from category_card.
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Screen'),
        backgroundColor: Colors.red[400],
      ),
      body: ExpenseFetcher(category),
    );
  }
}
