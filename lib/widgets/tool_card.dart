import 'package:flutter/material.dart';
import 'package:tool_organizer/objects/tool.dart';
import 'package:tool_organizer/pages/tool_info.dart';

class ToolCard extends StatelessWidget {
  final Tool tool;
  final Function(Tool) removeCallback;

  ToolCard(this.tool, {this.removeCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ToolInfo(
                      tool,
                      removeCallback: removeCallback,
                    )),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(tool.toolName),
              subtitle: Text(tool.barcode),
            ),
          ],
        ),
      ),
    );
  }
}
