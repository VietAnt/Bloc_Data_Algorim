import 'package:finance_money/database/database_provider.dart';
import 'package:finance_money/widgets/all_expense_screen/1_expense_search.dart';
import 'package:finance_money/widgets/all_expense_screen/2_all_expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: AllExpenseFetcher
class AllExpenseFetcher extends StatefulWidget {
  const AllExpenseFetcher({super.key});

  @override
  State<AllExpenseFetcher> createState() => _AllExpenseFetcherState();
}

class _AllExpenseFetcherState extends State<AllExpenseFetcher> {
  late Future _allExpenseList;

  //*-->_getAllExpense
  Future _getAllExpenses() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchAllExpenses();
  }

  @override
  void initState() {
    super.initState();
    _allExpenseList = _getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _allExpenseList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ExpenseSearch(),
                    Expanded(child: AllExpensesList()),
                  ],
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
