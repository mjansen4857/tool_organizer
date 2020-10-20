import 'package:flutter/material.dart';
import 'package:tool_organizer/pages/tool_info.dart';

class ToolCard extends StatelessWidget {
  final String toolName;
  final String subtitle;
  final String barcode;

  ToolCard(this.toolName, this.subtitle, this.barcode);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ToolInfo(barcode)),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(toolName),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
