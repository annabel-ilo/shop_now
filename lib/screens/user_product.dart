import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/models/product.dart';
import 'package:shop_now/widgets/user_prod_item.dart';

import '../const/route.dart';
import '../models/prod_provider.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(editProductScreenRoute);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (context, index) => Column(
                  children: [
                    UserProductsItem(
                      id: productsData.items[index].id,
                      title: productsData.items[index].title,
                      imageUrl: productsData.items[index].imageUrl,
                    ),
                    Divider()
                  ],
                )),
      ),
    );
  }
}
