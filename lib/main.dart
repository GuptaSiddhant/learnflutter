// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
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
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        accentColor: Colors.blue,
        // buttonColor: Colors.blue,      
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.lightBlue,
      ),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(
              products: _products,
            ),
        '/admin': (BuildContext context) => ProductsAdminPage(
              products: _products,
              addProduct: _addProduct,
              deleteProduct: _deleteProduct,
            ),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(_products[index]),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(
                products: _products,
              ),
        );
      },
    );
  }
}
