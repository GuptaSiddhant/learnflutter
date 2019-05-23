import 'package:flutter/material.dart';
import './product_create.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Menu'),
                ),
                ListTile(
                  title: Text('Products List'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Admin'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Create Product',
                  icon: Icon(Icons.add),
                ),
                Tab(
                  text: 'Products',
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(),
              ProductListPage(),
            ],
          )

          // bottomNavigationBar: ,
          ),
    );
  }
}
