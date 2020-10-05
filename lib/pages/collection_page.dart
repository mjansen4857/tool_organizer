import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/widgets/tool_card.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: <Widget>[
            ToolCard('Test Tool 1'),
            ToolCard('Test Tool 2'),
            ToolCard('Test Tool 3'),
            ToolCard('Test Tool 4'),
            ToolCard('Test Tool 5'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
