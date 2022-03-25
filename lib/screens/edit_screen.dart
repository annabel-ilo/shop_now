import 'package:flutter/material.dart';
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
  var _editedProduct = Product(
    id: "",
    title: " ",
    description: " ",
    price: 0,
    imageUrl: " ",
  );

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

  void _saveForm() {
    _form.currentState!.save();
    print(_editedProduct.description);
    print(_editedProduct.id);
    print(_editedProduct.title);
    print(_editedProduct.imageUrl);
    print(_editedProduct.price);
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
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
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
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
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
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
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.multiline,
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
                    height: 100,
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
