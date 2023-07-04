import 'package:finance_money/widgets/category_screen/4_category_fetcher.dart';
import 'package:finance_money/widgets/expense_form.dart';
import 'package:flutter/material.dart';

//Todo: CategoryScreen
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen'; // for routes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.red[400],
      ),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const ExpenseForm(),
          );
        },
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.add),
      ),
    );
  }
}
