import 'package:flutter/material.dart';

class ToolCard extends StatelessWidget {
  final String toolName;

  ToolCard(this.toolName);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(toolName),
              subtitle: Text('Not Lent'),
            ),
          ],
        ),
      ),
    );
  }
}
