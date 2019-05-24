import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function addProduct;
  final Function updateProduct;
  final int productIndex;
  ProductEditPage(
      {this.addProduct, this.product, this.updateProduct, this.productIndex});

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

  Widget _buildTitleTextField() {
    return TextFormField(
      initialValue: widget.product == null ? '' : widget.product['title'],
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

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      initialValue: widget.product == null ? '' : widget.product['description'],
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

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue:
          widget.product == null ? '' : widget.product['price'].toString(),
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


  Widget _buildPageContent(BuildContext context) {
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
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Add Item'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_productAddFormKey.currentState.validate()) {
      return;
    }
    _productAddFormKey.currentState.save();
    final Map<String, dynamic> product = _formData;
    if (widget.product == null) {
      widget.addProduct(product);
    } else {
      widget.updateProduct(product: product, index: widget.productIndex);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }



  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buildPageContent(context);
    
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
