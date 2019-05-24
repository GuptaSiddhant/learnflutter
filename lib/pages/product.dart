import 'dart:async';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage(this.title, this.imageUrl);

  _showWarningDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sure?'),
          content: Text('Delete the item.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancal'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child:
                  Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            )
          ],
        );
      },
    );
  }

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
                  onPressed: () => _showWarningDialog(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
