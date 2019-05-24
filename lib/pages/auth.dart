import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue = '';
  String _passwordValue = '';
  bool _termsValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'E-Mail'),
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) {
              setState(() {
                _emailValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (String value) {
              setState(() {
                _passwordValue = value;
              });
            },
          ),
          SwitchListTile(
            value: _termsValue,
            onChanged: (bool value) {
              setState(() {
                _termsValue = value;
              });
            },
            title: Text('Accept Terms'),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Login'),
              onPressed: () {
                print(_emailValue + ' - ' + _passwordValue);
                Navigator.pushReplacementNamed(context, 'auth');
              },
            ),
          ),
        ]),
      ),
    );
  }
}
