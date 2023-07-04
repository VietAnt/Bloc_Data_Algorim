import 'package:favorite_provider/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: 1.FavoritePage
class FavoritePage extends StatelessWidget {
  static const routeName = 'favorite_page';
  static const fullPath = '/$routeName';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<Favorite>(
        builder: (context, value, child) {
          return value.items.isNotEmpty
              ? ListView.builder(
                  itemCount: value.items.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    return FavoriteItemTile(value.items[index]);
                  },
                )
              : const Center(child: const Text('No Favorite added'));
        },
      ),
    );
  }
}

//Todo: 2.FavoriteItemTile
class FavoriteItemTile extends StatelessWidget {
  final int itemNo;

  const FavoriteItemTile(this.itemNo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
