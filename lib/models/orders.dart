import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_now/models/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    const url =
        'https://shop-now-ee090-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> loaderOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((orderId, orderData) {
      // if (extractedData == null) {
      //   return;
      // }
      loaderOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity'],
                ))
            .toList(),
        dateTime: DateTime.parse(orderData['dateTime']),
      ));
    });
    _orders = loaderOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url =
        'https://shop-now-ee090-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'DateTime': timeStamp.toIso8601String(),
            'product': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timeStamp,
          ));
    } catch (error) {
      rethrow;
    }

    notifyListeners();
  }
}
