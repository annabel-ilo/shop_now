import 'package:flutter/material.dart';

import '../const/route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello There!'),
          ),
          const Divider(thickness: 5.0),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(productOverviewScreenRoute);
            },
          ),
          const Divider(thickness: 5.0),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(orderScreenRoute);
            },
          ),
           const Divider(thickness: 5.0),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(userProductsRoute);
            },
          )
        ],
      ),
    );
  }
}
