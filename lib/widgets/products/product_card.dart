import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import './address_tag.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCardWidget(this.product, this.productIndex);

  Widget _buildProductImage() {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      width: 100.0,
      height: 100.0,
      child: Image.asset(
        product.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProductTitle() {
    return Container(
      child: Text(
        product.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // color: Theme.of(context).primaryColor,
          fontSize: 24.0,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return IconButton(
            padding: EdgeInsets.all(0),
            icon: model.allProducts[productIndex].isFavourite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              model.selectProduct(productIndex);
              model.toggleProductFavouriteStatus();
            },
          );
        }),
        IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pushNamed<bool>(
                context,
                '/product/' + productIndex.toString(),
              ).then((bool value) {
                // if (value) {
                //   deleteProduct(productIndex);
                // }
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Container(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildProductImage(),
              ],
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildProductTitle(),
                  SizedBox(height: 8.0),
                  AddressTagWidget('Kamppi, Helsinki, Finland'),
                  Text(product.userEmail),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                PriceTagWidget(product.price.toString()),
                _buildActionButtons(context),
              ],
            ),
            SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}
