import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/models/cart.dart' show Cart;
import 'package:shop_now/models/orders.dart';
import 'package:shop_now/widgets/card_item_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false,).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        cart.clear();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: ((context, index) => CardItem(
                      id: cart.items.values.toList()[index].id,
                      productId: cart.items.keys.toList()[index],
                      price: cart.items.values.toList()[index].price,
                      quantity: cart.items.values.toList()[index].quantity,
                      title: cart.items.values.toList()[index].title,
                    ))),
          )
        ],
      ),
    );
  }
}
