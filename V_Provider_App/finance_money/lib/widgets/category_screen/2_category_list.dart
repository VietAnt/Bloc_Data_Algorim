import 'package:finance_money/database/database_provider.dart';
import 'package:finance_money/widgets/category_screen/1_category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: CategoryList
class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, database, __) {
        //get the categories
        var list = database.categories;

        return ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: list.length,
          itemBuilder: (_, index) => CategoryCard(list[index]),
        );
      },
    );
  }
}
