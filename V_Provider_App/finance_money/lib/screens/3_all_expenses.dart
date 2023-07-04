import 'package:finance_money/widgets/all_expense_screen/3_all_expenses_fetcher.dart';
import 'package:flutter/material.dart';

//Todo: AllExpenses
class AllExpenses extends StatefulWidget {
  const AllExpenses({super.key});
  static const name = '/all_expenses';

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Expenses'),
        backgroundColor: Colors.red[400],
      ),
      body: const AllExpenseFetcher(),
    );
  }
}
