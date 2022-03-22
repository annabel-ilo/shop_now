import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/const/route.dart';
import 'package:shop_now/models/cart.dart';
import 'package:shop_now/widgets/app_drawer.dart';
import 'package:shop_now/widgets/badge.dart';
import 'package:shop_now/widgets/product_item.dart';

import '../widgets/product_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorite) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (value) => [
                    PopupMenuItem(
                      child: Text('Favorite'),
                      value: FilterOptions.favorite,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.all,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              child: child as Widget,
              value: cart.itemCount.toString(),
              color: Colors.grey,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(cartScreenRoute);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(
        showFavs: _showOnlyFavorite,
      ),
    );
  }
}

enum FilterOptions {
  favorite,
  all,
}
