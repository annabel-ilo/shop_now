// ignore_for_file: deprecated_member_use
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/const/route.dart';
import 'package:shop_now/models/cart.dart';
import 'package:shop_now/models/orders.dart';
import 'package:shop_now/screens/cart_screen.dart';
import 'package:shop_now/screens/order_screen.dart';

import 'package:shop_now/screens/product_detail_screen.dart';
import 'package:shop_now/screens/product_overview.dart';
import 'package:shop_now/screens/user_product.dart';

import 'models/prod_provider.dart';
import 'screens/edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amberAccent),
          accentColor: Colors.amber,
          fontFamily: 'Lato',
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          productDetailScreenRoute: (context) => const ProductDetailScreen(),
          productOverviewScreenRoute: (context) =>
              const ProductsOverviewScreen(),
          cartScreenRoute: (context) => const CartScreen(),
          orderScreenRoute: (context) => const OrdersScreen(),
          userProductsRoute: (context) => const UserProductsScreen(),
          editProductScreenRoute: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
