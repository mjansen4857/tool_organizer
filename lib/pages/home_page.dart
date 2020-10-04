import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({this.username});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tool Organizer'),
      ),
      drawer: buildDrawer(),
      body: buildPageContent(),
    );
  }

  Widget buildPageContent() {
    return Text('Signed in as: ' + widget.username);
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
              Icons.build,
            ),
            title: Text('Some page 1'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.build,
            ),
            title: Text('Some page 2'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.build,
            ),
            title: Text('Some page 3'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
