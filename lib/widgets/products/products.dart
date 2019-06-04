import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class Products extends StatelessWidget {
  // final List<Product> products;
  // final Function deleteProduct;

  // Products(this.products, {this.deleteProduct});

  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            ProductCardWidget(products[index], index),
      );
    } else {
      productCards = Center(
        child: Text('No Cards'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.displayedProducts);
      },
    );
  }
}
