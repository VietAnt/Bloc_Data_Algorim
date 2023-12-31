import 'package:finance_money/database/database_provider.dart';
import 'package:finance_money/screens/3_all_expenses.dart';
import 'package:finance_money/widgets/category_screen/2_category_list.dart';
import 'package:finance_money/widgets/category_screen/3_total_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: CategoryFetcher
class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {
  late Future _categoryList;

  Future _getCategoryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchCategories();
  }

  @override
  void initState() {
    // lấy danh sách và đặt nó thành _categoryList
    _categoryList = _getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoryList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // nếu kết nối xong thì kiểm tra lỗi hoặc trả về kết quả
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: TotalChart(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expense',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AllExpenses.name);
                        },
                        child: Text('View All'),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: CategoryList(),
                  ),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
