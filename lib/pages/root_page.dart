import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool loggedIn = false;
  String username;

  @override
  void initState() {
    super.initState();
    loggedIn = false;
    username = null;
  }

  void loginCallback(String username) {
    setState(() {
      loggedIn = true;
      this.username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return LoginPage(loginCallback: loginCallback);
    } else {
      return HomePage(username: username);
    }
  }
}
