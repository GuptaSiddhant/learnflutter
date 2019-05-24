import 'package:flutter/material.dart';

class PriceTagWidget extends StatelessWidget {
  final String price;
  PriceTagWidget(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        '\$' + price,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
