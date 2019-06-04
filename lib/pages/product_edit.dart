// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  // final Product product;
  // final Function addProduct;
  // final Function updateProduct;
  // final int productIndex;
  // ProductEditPage(
  //     {this.addProduct, this.product, this.updateProduct, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'imageUrl': 'assets/photo.jpeg',
  };
  final GlobalKey<FormState> _productAddFormKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.title,
      decoration: InputDecoration(labelText: 'Title'),
      autofocus: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required (5+ chars)';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      maxLines: 4,
      initialValue: product == null ? '' : product.description,
      decoration: InputDecoration(labelText: 'Description'),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required (10+ chars)';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.price.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
          return 'Price is required';
        }
      },
      onSaved: (String value) {
        _formData['price'] = value;
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 0.9;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(16.0),
        child: Form(
          key: _productAddFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(height: 10.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Add Item'),
          onPressed: () => _submitForm(
                model.addProduct,
                model.updateProduct,
                model.selectProduct,
                model.selectedProductIndex,
              ),
        );
      },
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    if (!_productAddFormKey.currentState.validate()) {
      return;
    }
    _productAddFormKey.currentState.save();
    // final Product product = Product(
    //   title: _formData["title"],
    //   description: _formData['description'],
    //   price: double.parse(_formData['price']),
    //   image: _formData['imageUrl'],
    // );
    if (selectedProductIndex == null) {
      addProduct(
        _formData["title"],
        _formData['description'],
        _formData['imageUrl'],
        double.parse(_formData['price']),
      );
    } else {
      updateProduct(
        _formData["title"],
        _formData['description'],
        _formData['imageUrl'],
        double.parse(_formData['price']),
      );
    }
    Navigator.pushReplacementNamed(context, '/products')
        .then((_) => setSelectedProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
