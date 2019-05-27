import 'package:flutter/material.dart';
import './product_edit.dart';
import './product_list.dart';
// import '../models/product.dart';

class ProductsAdminPage extends StatefulWidget {
  // final List<Product> products;
  // final Function addProduct;
  // final Function updateProduct;
  // final Function deleteProduct;

  // ProductsAdminPage(
  //     {this.products, this.updateProduct, this.addProduct, this.deleteProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductAdminPageState();
  }
}

class _ProductAdminPageState extends State<ProductsAdminPage> {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Products List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Admin'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Create Product',
                  // icon: Icon(Icons.add),
                ),
                Tab(
                  text: 'Products',
                  // icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(),
              ProductListPage(),
            ],
          )

          // bottomNavigationBar: ,
          ),
    );
  }
}
