import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_now/models/cart.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.productId,
  }) : super(key: key);

  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
      ),
      child: Card(
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(child: Text('\$$price')),
              ),
              title: Text(title),
              subtitle: Text(
                'Total: \$${(price * quantity)}',
              ),
              trailing: Text('$quantity x'),
            ),
          )),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(productId);
      },
    );
  }
}
