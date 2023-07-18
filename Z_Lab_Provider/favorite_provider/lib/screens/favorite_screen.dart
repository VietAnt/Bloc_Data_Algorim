import 'package:favorite_provider/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: FavoritePage
class FavoritePage extends StatelessWidget {
  static const routeName = 'favorite_page';
  static const fullPath = '/$routeName';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: Consumer<Favorite>(
        builder: (context, value, child) {
          return value.items.isNotEmpty
              ? ListView.builder(
                  itemCount: value.items.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    return FavoriteItemTile(
                      itemNo: value.items[index],
                    );
                  },
                )
              : const Center(child: Text('No Favorite Add'));
        },
      ),
    );
  }
}

//Todo: FovoriteItem
class FavoriteItemTile extends StatelessWidget {
  final int itemNo;

  const FavoriteItemTile({required this.itemNo, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('favorite_text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('remove_icon_$itemNo'),
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<Favorite>().remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorite'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
