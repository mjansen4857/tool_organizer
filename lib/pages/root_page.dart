import 'package:flutter/material.dart';
import 'package:tool_organizer/services/database.dart';

import 'home_page.dart';
import 'login_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool _isLoading = true;
  bool _loggedIn = false;
  String _username;
  String _fullname;

  @override
  void initState() {
    super.initState();
    _loggedIn = false;
    _username = null;
    Database.openConnection().then((value) => setState(() {
          _isLoading = false;
        }));
  }

  void loginCallback(String username, String fullname) {
    setState(() {
      _loggedIn = true;
      this._username = username;
      this._fullname = fullname;
    });
  }

  void logoutCallback() {
    setState(() {
      _loggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return buildLoading();
    }
    if (!_loggedIn) {
      return LoginPage(
        loginCallback: loginCallback,
      );
    } else {
      return HomePage(
        username: _username,
        fullname: _fullname,
        logoutCallback: logoutCallback,
      );
    }
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
