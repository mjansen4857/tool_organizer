import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function(String) loginCallback;

  LoginPage({this.loginCallback});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
