import 'package:flutter/material.dart';
import 'package:tool_organizer/services/database.dart';

import 'home_page.dart';
import 'login_page.dart';

class RootPage extends StatefulWidget {
  final Database db;

  RootPage({this.db});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool _isLoading = true;
  bool _loggedIn = false;
  String username;

  @override
  void initState() {
    super.initState();
    _loggedIn = false;
    username = null;
    widget.db.openConnection().then((value) => setState(() {
          _isLoading = false;
        }));
  }

  void loginCallback(String username) {
    setState(() {
      _loggedIn = true;
      this.username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return buildLoading();
    }
    if (!_loggedIn) {
      return LoginPage(loginCallback: loginCallback);
    } else {
      return HomePage(username: username);
    }
  }

  Widget buildLoading() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }
}
