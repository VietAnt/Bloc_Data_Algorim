// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';

//Todo: Cart
class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            CartTotal(),
          ],
        ),
      ),
    );
  }
}

//Todo:1. CartList
class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    // Điều này lấy trạng thái hiện tại của CartModel và cũng báo cho Flutter
    // để xây dựng lại tiện ích này khi CartModel thông báo cho người nghe (nói cách khác,
    // khi nó thay đổi).
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.done),
          trailing: IconButton(
            onPressed: () {
              cart.remove(cart.items[index]);
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
          title: Text(
            cart.items[index].name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }
}

//Todo: 2.CartTotal
class CartTotal extends StatelessWidget {
  const CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Một cách khác để lắng nghe sự thay đổi của model là bao gồm
            // tiện ích Người tiêu dùng. Widget này sẽ tự động lắng nghe
            // tới CartModel và chạy lại trình tạo của nó sau mỗi lần thay đổi
            // Điều quan trọng là nó sẽ không xây dựng lại
            // phần còn lại của các widget trong phương thức xây dựng này.
            Consumer<CartModel>(
              builder: (context, cart, child) =>
                  Text('\$${cart.totalPrice}', style: hugeStyle),
            ),
            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Buying not supported yet.')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
