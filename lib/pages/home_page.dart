import 'package:flutter/material.dart';
import 'package:tool_organizer/pages/borrowed_tools.dart';
import 'package:tool_organizer/pages/my_tools.dart';

enum PageState { MY_TOOLS, BORROWED_TOOLS }

class HomePage extends StatefulWidget {
  final String username;
  final String fullname;
  final VoidCallback logoutCallback;

  HomePage({this.username, this.fullname, this.logoutCallback});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageState _pageState = PageState.MY_TOOLS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppBarText()),
      ),
      drawer: buildDrawer(),
      body: buildPageContent(),
    );
  }

  String getAppBarText() {
    switch (_pageState) {
      case PageState.BORROWED_TOOLS:
        return 'Borrowed Tools';
      case PageState.MY_TOOLS:
      default:
        return 'My Tools';
    }
  }

  Widget buildPageContent() {
    switch (_pageState) {
      case PageState.BORROWED_TOOLS:
        return BorrowedTools(
          username: widget.username,
        );
      case PageState.MY_TOOLS:
      default:
        return MyTools(
          username: widget.username,
          fullname: widget.fullname,
        );
    }
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text(widget.username),
                  accountName: Text(widget.fullname),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey[850],
                    child: Icon(
                      Icons.build,
                      size: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.business_center,
                  ),
                  title: Text('My Tools'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _pageState = PageState.MY_TOOLS;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.build,
                  ),
                  title: Text('Borrowed Tools'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _pageState = PageState.BORROWED_TOOLS;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sign out'),
                      onTap: widget.logoutCallback,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
