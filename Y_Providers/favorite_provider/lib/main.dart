import 'package:favorite_provider/models/favorites.dart';
import 'package:favorite_provider/screens/favorite.dart';
import 'package:favorite_provider/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FavoriteApp());
}

GoRouter router() {
  return GoRouter(
    routes: [
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: FavoritePage.routeName,
            builder: (context, state) => const FavoritePage(),
          ),
        ],
      ),
    ],
  );
}

class FavoriteApp extends StatelessWidget {
  const FavoriteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contetx) => Favorite(),
      child: MaterialApp.router(
        title: 'Favorite App',
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        routerConfig: router(),
      ),
    );
  }
}
