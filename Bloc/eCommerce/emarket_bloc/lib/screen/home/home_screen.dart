import 'package:emarket_bloc/model/model.dart';
import 'package:emarket_bloc/screen/category/category_screem.dart';
import 'package:emarket_bloc/widget/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'eMarket'),
      body: Column(
        children: [
          const SectionTitle(title: 'Category'),
          CategorySelection(categories: Category.categories),
          const SectionTitle(title: 'Recommended'),
        ],
      ),
    );
  }
}
