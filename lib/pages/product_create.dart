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

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              autofocus: true,
              onChanged: (String value) {
                setState(() {
                  _titleValue = value;
                });
              },
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (String value) {
                setState(() {
                  _descriptionValue = value;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
              onChanged: (String value) {
                setState(() {
                  _priceValue = double.parse(value);
                });
              },
            ),
            Container(
                margin: EdgeInsets.all(8.0),
                child: RaisedButton(
                  // textColor: Colors.white,
                  child: Text('Create Item'),
                  onPressed: () {
                    final Map<String,dynamic> product = {
                      'title': _titleValue,
                      'description': _descriptionValue,
                      'price': _priceValue,
                      'imageUrl': 'assets/photo.jpeg',
                    };
                    widget.addProduct(product);

                    Navigator.pushReplacementNamed(context, '/products');                  
                  },
                ))
          ],
        ));
  }
}
