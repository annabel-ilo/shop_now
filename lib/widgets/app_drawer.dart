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
            title: Text('Hello There!'),
          ),
          Divider(thickness: 5.0),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(productOverviewScreenRoute);
            },
          ),
          Divider(thickness: 5.0),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(orderScreenRoute);
            },
          ),
           Divider(thickness: 5.0),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Product'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(userProductsRoute);
            },
          )
        ],
      ),
    );
  }
}
