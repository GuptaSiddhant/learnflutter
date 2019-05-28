import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';

import '../scoped-models/products_model.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(
      BuildContext context, int index, ProductsModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage(
                  // product: products[index],
                  // updateProduct: updateProduct,
                  // productIndex: index,
                  );
            },
          ),
        );
      },
    );
  }

  Widget _buildListItem(BuildContext context, int index, ProductsModel model) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              model.products[index].image,
            ),
          ),
          title: Text(model.products[index].title),
          subtitle: Text('\$' + model.products[index].price.toString()),
          trailing: _buildEditButton(context, index, model),
        ),
        Divider(
          indent: 70.0,
          height: 1.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.products[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                } else if (direction == DismissDirection.startToEnd) {
                } else {}
              },
              background: Container(
                color: Colors.red,
              ),
              child: _buildListItem(context, index, model),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}
