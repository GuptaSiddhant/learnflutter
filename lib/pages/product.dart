import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/products/price_tag.dart';
import '../widgets/products/address_tag.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage(this.product);

  // _showWarningDialog(context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Sure?'),
  //         content: Text('Delete the item.'),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('Cancal'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           FlatButton(
  //             child:
  //                 Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.pop(context, true);
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product['title']),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(product['imageUrl'], fit: BoxFit.cover),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      product['title'],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AddressTagWidget('Kamppi, Helsinki, Finland'),
                        SizedBox(
                          width: 8,
                        ),
                        PriceTagWidget(product['price'].toString()),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          product['description'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),

              // ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     RaisedButton(
              //       child: Text('Delete'),
              //       onPressed: () => _showWarningDialog(context),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
