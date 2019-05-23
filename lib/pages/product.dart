import 'dart:async';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Image.asset(imageUrl),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(title),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Delete'),
                  onPressed: () => Navigator.pop(
                        context,
                        true,
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
