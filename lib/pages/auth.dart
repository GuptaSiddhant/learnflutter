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

  DecorationImage _buildBackgroundImange() {
    return DecorationImage(
      image: AssetImage('assets/photo.jpeg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'E-Mail',
        filled: true,
        fillColor: Colors.white,
      ),
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _emailValue = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _passwordValue = value;
        });
      },
    );
  }

  Widget _buildTermsSwitch() {
    return SwitchListTile(
      value: _termsValue,
      onChanged: (bool value) {
        setState(() {
          _termsValue = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm() {
    print(_emailValue + ' - ' + _passwordValue);
    Navigator.pushReplacementNamed(context, 'auth');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImange()),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: targetWidth,
              child: Column(children: <Widget>[
                _buildEmailTextField(),
                SizedBox(height: 10.0),
                _buildPasswordTextField(),
                _buildTermsSwitch(),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Login'),
                    onPressed: _submitForm,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
