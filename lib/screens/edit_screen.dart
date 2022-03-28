import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_now/models/prod_provider.dart';
import 'package:shop_now/models/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var isInit = true;

  var _editedProduct = Product(
    id: "",
    title: " ",
    description: " ",
    price: 0,
    imageUrl: " ",
  );

  var _initProduct = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      _editedProduct = Provider.of<Products>(context).findById(productId);
      _initProduct = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        // 'imageUrl': _editedProduct.imageUrl,
        'imageUrl': '',
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      // if (_imageUrlController.text.isEmpty ||
      //     _imageUrlController.text.endsWith('.pdf') &&
      //         _imageUrlController.text.endsWith('.jpeg') &&
      //         _imageUrlController.text.endsWith('.jpg') &&
      //         _imageUrlController.text.endsWith('.png') ||
      //     _imageUrlController.text.startsWith('http') &&
      //         _imageUrlController.text.startsWith('https')) {
      //   return;
      // }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                  initialValue: _initProduct['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Add a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: " ",
                      title: value as String,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  }),
              TextFormField(
                  initialValue: _initProduct['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Add an Amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'enter a valid amount';
                    }
                    if (double.parse(value) <= 0) {
                      return 'amount must be greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: " ",
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl,
                    );
                  }),
              TextFormField(
                  initialValue: _initProduct['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter a description';
                    }
                    if (value.length < 10) {
                      return 'add more info';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: " ",
                      title: _editedProduct.title,
                      description: value as String,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                    );
                  }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 120,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isNotEmpty
                        ? const Text('enter Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image Url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'enter a url';
                        //   }
                        //   if ((value.endsWith('.pdf') &&
                        //       value.endsWith('.jpeg') &&
                        //       value.endsWith('.jpg') &&
                        //       value.endsWith('.png'))) {
                        //     return 'image must be either a pdf , jpeg , jpg or png ';
                        //   }
                        //   if ((value.startsWith('http') &&
                        //       value.startsWith('https'))) {
                        //     return 'return a valid link';
                        //   }
                        //   return null;
                        // },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: " ",
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value as String,
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _saveForm,
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
