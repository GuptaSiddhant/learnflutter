import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  // final List<Map<String, dynamic>> products;
  final Function addProduct;
  // final Function deleteProduct;
  ProductCreatePage({this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue = 0.0;

  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Title'),
      autofocus: true,
      onChanged: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Description'),
      onChanged: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      onChanged: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
    );
  }

  void _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'imageUrl': 'assets/photo.jpeg',
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 0.9;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
        width: targetWidth,
        margin: EdgeInsets.all(16.0),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
            GestureDetector(
              onTap: _submitForm,
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
                color: Colors.green,
                child: Text(
                  'Add Item',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
