import 'package:favorite_provider/models/favorites.dart';
import 'package:favorite_provider/screens/favorite.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//Todo: HomePage
class HomePage extends StatelessWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Provider'),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.go(FavoritePage.fullPath);
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text('Favorite'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        cacheExtent: 20,
        controller: ScrollController(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(itemNo: index),
      ),
    );
  }
}

//Todo: ItemTile
class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile({required this.itemNo, super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteList = context.watch<Favorite>();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoriteList.items.contains(itemNo)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          onPressed: () {
            !favoriteList.items.contains(itemNo)
                ? favoriteList.add(itemNo)
                : favoriteList.remove(itemNo);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(favoriteList.items.contains(itemNo)
                    ? 'Added to favorites'
                    : 'Removed from favorites'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
