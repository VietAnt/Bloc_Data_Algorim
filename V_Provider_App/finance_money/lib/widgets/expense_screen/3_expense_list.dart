import 'package:finance_money/database/database_provider.dart';
import 'package:finance_money/widgets/expense_screen/2_expese_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: ExpenseList: Danh_Sach_Giao_Dich
class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var expenseList = db.expenses;

        return expenseList.isNotEmpty
            ? ListView.builder(
                itemCount: expenseList.length,
                itemBuilder: (_, index) {
                  return ExpenseCard(expense: expenseList[index]);
                },
              )
            : const Center(
                child: Text('No Expense Added'),
              );
      },
    );
  }
}
