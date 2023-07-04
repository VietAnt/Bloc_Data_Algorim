// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';

//Todo: MyCatalog
class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

//Todo: AddButton
class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Phương thức context.select() sẽ cho bạn nghe những thay đổi của
    // một *phần* của mô hình. Bạn định nghĩa một hàm "chọn" (tức là trả về)
    // phần bạn quan tâm và gói nhà cung cấp sẽ không xây dựng lại
    // tiện ích này trừ khi phần cụ thể đó của mô hình thay đổi.
    // Điều này có thể dẫn đến cải thiện hiệu suất đáng kể.
    var isInCart = context.select<CartModel, bool>(
      // Ở đây, chúng tôi chỉ quan tâm đến việc [item] có trong giỏ hàng hay không.
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              // Nếu mặt hàng không có trong giỏ hàng, chúng tôi cho phép người dùng thêm nó.
              // Chúng tôi đang sử dụng context.read() ở đây vì gọi lại
              // được thực thi bất cứ khi nào người dùng chạm vào nút. trong khác
              // từ, nó được thực thi bên ngoài phương thức xây dựng.
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

//Todo: MyApp
class _MyAppBar extends StatelessWidget {
  const _MyAppBar({super.key});

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
class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
        // Ở đây, chúng tôi chỉ quan tâm đến mục tại [index]. chúng tôi không quan tâm
        // về bất kỳ thay đổi nào khác.
        (catalog) => catalog.getByPosition(index));

    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
