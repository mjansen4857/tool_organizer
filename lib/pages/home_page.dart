import 'package:flutter/material.dart';
import 'package:tool_organizer/pages/analytics_page.dart';
import 'package:tool_organizer/pages/borrowed_tools.dart';
import 'package:tool_organizer/pages/my_tools.dart';

enum PageState { MY_TOOLS, BORROWED_TOOLS, ANALYTICS }

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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: buildDrawer(),
        body: buildPageContent(),
      ),
    );
  }

  Widget buildAppBar() {
    if (_pageState == PageState.ANALYTICS) {
      return AppBar(
        title: Text(getAppBarText()),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text: 'Missing Tools'),
            Tab(text: 'Most Lent'),
            Tab(text: 'Biggest Lenders'),
            Tab(text: 'Biggest Borrowers'),
            Tab(text: 'Biggest Collections'),
          ],
        ),
      );
    } else {
      return AppBar(
        title: Text(getAppBarText()),
      );
    }
  }

  String getAppBarText() {
    switch (_pageState) {
      case PageState.BORROWED_TOOLS:
        return 'Borrowed Tools';
      case PageState.ANALYTICS:
        return 'Analytics';
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
      case PageState.ANALYTICS:
        return AnalyticsPage(
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
                ListTile(
                  leading: Icon(
                    Icons.cloud,
                  ),
                  title: Text('Analytics'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _pageState = PageState.ANALYTICS;
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
