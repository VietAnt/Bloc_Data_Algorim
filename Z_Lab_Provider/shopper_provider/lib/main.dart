import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopper_provider/common/theme.dart';
import 'package:shopper_provider/models/cart.dart';
import 'package:shopper_provider/models/catalog.dart';
import 'package:shopper_provider/screens/catalog.dart';
import 'package:shopper_provider/screens/login.dart';
import 'package:shopper_provider/screens/my_catalog.dart';

void main() {
  runApp(const MyApp());
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng MultiProvider thuận tiện khi cung cấp nhiều đối tượng.
    return MultiProvider(
      providers: [
        // Trong ứng dụng mẫu này, CatalogModel không bao giờ thay đổi,
        // do đó, một Nhà cung cấp đơn giản là đủ.
        Provider(create: (context) => CatalogModel()),
        // CartModel được triển khai dưới dạng ChangeNotifier, yêu cầu sử dụng
        // của ChangeNotifierProvider. Hơn nữa, CartModel phụ thuộc
        // trên CatalogModel, vì vậy cần có ProxyProvider.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
