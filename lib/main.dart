import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, String>> _products = [];

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
      ),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => ProductsPage(
              products: _products,
              addProduct: _addProduct,
              deleteProduct: _deleteProduct,
            ),
        '/auth': (BuildContext context) => AuthPage(),
        '/admin': (BuildContext context) => ProductsAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(
                  _products[index]['title'], _products[index]['imageUrl']));
        }
        return null;
      },
    );
  }
}