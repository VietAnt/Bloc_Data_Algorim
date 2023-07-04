import 'package:finance_money/database/database_provider.dart';
import 'package:finance_money/widgets/expense_screen/2_expese_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: AllExpenseList
class AllExpensesList extends StatelessWidget {
  const AllExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, database, __) {
        var list = database.expenses;

        return list.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: list.length,
                itemBuilder: (_, index) => ExpenseCard(expense: list[index]),
              )
            : const Center(child: Text('No Entries Found'));
      },
    );
  }
}
