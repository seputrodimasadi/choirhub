import "package:flutter/material.dart";

import "../mixins/validation_mixin.dart";

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}


class LoginScreenState extends State<LoginScreen> with ValidationMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _emailField(),
            _passwordField(),
            Container(margin: EdgeInsets.only(top:24.0)),
            _submitButton(),
            _resetButton(),
          ],
        ),
      ),
    );
  }







  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'you@example.com',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '******',
      ),
      obscureText: true,
      validator: validatePassword,
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _submitButton() {
    return RaisedButton(
      child: Text('Submit', style: TextStyle(color: Colors.white),),
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          print('Time to post $_email and $_password');

        }
      },
    );
  }

  Widget _resetButton() {
    return RaisedButton(
      child: Text('Reset', style: TextStyle(color: Colors.white),),
      color: Colors.grey,
      onPressed: () {
        _formKey.currentState.reset();
      },
    );
  }

}