import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/models/orders.dart' show Orders;
import 'package:shop_now/widgets/app_drawer.dart';

import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future ? _orderFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context).fetchAndSetOrder();
  }

  @override
  void initState() {
    //_orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _orderFuture,
              //Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(child: Text('Something went wrong'));
              } else {
                return Consumer<Orders>(builder: (context, orderData, child) {
                  ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (context, index) => OrderItem(
                      order: orderData.orders[index],
                    ),
                  );
                  return const Center(child: Text('Order Screen'));
                });
              }
            }
          },
        ));
  }
}
