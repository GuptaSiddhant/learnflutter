import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _userCredentials = {
    'email': null,
    'password': null,
    'acceptTerms': false,
  };

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

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
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-Mail',
        filled: true,
        fillColor: Colors.white,
      ),
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        _userCredentials['email'] = value;
      },
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Email is required';
        }
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onSaved: (String value) {
        _userCredentials['password'] = value;
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 8) {
          return 'Password is required (8+ characters)';
        }
      },
    );
  }

  Widget _buildTermsSwitch() {
    return SwitchListTile(
      value: _userCredentials['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _userCredentials['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function login) {
    if (!_loginFormKey.currentState.validate() ||
        !_userCredentials['acceptTerms']) {
      return;
    }
    _loginFormKey.currentState.save();
    login(_userCredentials['email'], _userCredentials['password']);
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(image: _buildBackgroundImange()),
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                width: targetWidth,
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextField(),
                      SizedBox(height: 10.0),
                      _buildPasswordTextField(),
                      _buildTermsSwitch(),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        child: ScopedModelDescendant<MainModel>(
                          builder: (BuildContext context, Widget child,
                              MainModel model) {
                            return RaisedButton(
                              child: Text('Login'),
                              onPressed: () => _submitForm(model.login),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
