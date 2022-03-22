import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/prod_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              )),
          SizedBox(height: 10),
          Text(
            '\$${loadedProduct.price}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              '${loadedProduct.description}',
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ],
      )),
    );
  }
}
