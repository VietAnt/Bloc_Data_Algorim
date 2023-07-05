import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopper_provider/models/cart.dart';
import 'package:shopper_provider/models/catalog.dart';

//Todo: 1.MyCatalog
class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MyAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => MyListItem(index),
            ),
          ),
        ],
      ),
    );
  }
}

//Todo: 2.AddButton

class AddButton extends StatelessWidget {
  final Item item;

  const AddButton({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              // Nếu mặt hàng không có trong giỏ hàng,
              //chúng tôi cho phép người dùng thêm nó.
              // Chúng tôi đang sử dụng context.read() ở đây vì gọi lại
              // được thực thi bất cứ khi nào người dùng chạm vào nút. trong khác
              // từ, nó được thực thi bên ngoài phương thức xây dựng.
              context.read<CartModel>().add(item);
            },
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

//Todo: MyApp
class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        IconButton(
          onPressed: () => context.go('/catalog/cart'),
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }
}

//Todo: MyListItem
class MyListItem extends StatelessWidget {
  final int index;

  const MyListItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      // Ở đây, chúng tôi chỉ quan tâm đến mục tại [index].
      // chúng tôi không quan tâm về bất kỳ thay đổi nào khác.
      (catalog) => catalog.getByPosition(index),
    );
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                item.name,
                style: textTheme,
              ),
            ),
            const SizedBox(width: 24),
            AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
