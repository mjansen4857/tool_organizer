import 'package:flutter/material.dart';
import 'package:tool_organizer/pages/collection_page.dart';

enum PageState { COLLECTION, PLACEHOLDER1, PLACEHOLDER2 }

class HomePage extends StatefulWidget {
  final String username;

  HomePage({this.username});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageState _pageState = PageState.COLLECTION;

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
      case PageState.PLACEHOLDER1:
        return 'Placeholder 1';
      case PageState.PLACEHOLDER2:
        return 'Placeholder 2';
      case PageState.COLLECTION:
      default:
        return 'Tool Collection';
    }
  }

  Widget buildPageContent() {
    switch (_pageState) {
      case PageState.PLACEHOLDER1:
        return Text('Placeholder 1');
      case PageState.PLACEHOLDER2:
        return Text('Placeholder 2');
      case PageState.COLLECTION:
      default:
        return CollectionPage();
    }
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text(widget.username),
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
            title: Text('Collection'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _pageState = PageState.COLLECTION;
              });
            },
          ),
//          Divider(),
          ListTile(
            leading: Icon(
              Icons.build,
            ),
            title: Text('Placeholder 1'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _pageState = PageState.PLACEHOLDER1;
              });
            },
          ),
//          Divider(),
          ListTile(
            leading: Icon(
              Icons.build,
            ),
            title: Text('Placeholder 2'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _pageState = PageState.PLACEHOLDER2;
              });
            },
          ),
        ],
      ),
    );
  }
}
