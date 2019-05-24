import 'package:flutter/material.dart';

class AddressTagWidget extends StatelessWidget {
  final String addressValue;
  AddressTagWidget(this.addressValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(addressValue),
      // padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 1.0, color: Colors.grey),
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
    );
  }
}
