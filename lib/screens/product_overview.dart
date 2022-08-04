// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/const/route.dart';
import 'package:shop_now/models/cart.dart';
import 'package:shop_now/widgets/app_drawer.dart';
import 'package:shop_now/widgets/badge.dart';

import '../models/prod_provider.dart';
import '../widgets/product_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Products>(context, listen: false)
        .fetchAndUpdateProduct()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

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
              icon: const Icon(Icons.more_vert),
              itemBuilder: (value) => [
                    const PopupMenuItem(
                      child: Text('Favorite'),
                      value: FilterOptions.favorite,
                    ),
                    const PopupMenuItem(
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
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
               
                Navigator.of(context).pushNamed(cartScreenRoute);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body:

          // _isLoading

          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          ProductGrid(
        showFavs: _showOnlyFavorite,
      ),
    );
  }
}

enum FilterOptions {
  favorite,
  all,
}
