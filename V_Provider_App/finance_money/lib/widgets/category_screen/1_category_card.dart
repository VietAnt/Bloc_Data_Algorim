import 'package:finance_money/models/category.dart';
import 'package:finance_money/screens/1_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Todo: CategoryCard
class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;

  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          ExpenseScreen.name,
          arguments: category.title, //for expense screen
        );
      },
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(category.icon),
      ),
      title: Text(category.title),
      subtitle: Text('entries: ${category.entries}'),
      trailing: Text(
        NumberFormat.currency(locale: 'en_IN', symbol: '\$')
            .format(category.totalAmount),
      ),
    );
  }
}
