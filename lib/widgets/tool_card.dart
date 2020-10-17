import 'package:flutter/material.dart';

class ToolCard extends StatelessWidget {
  final String toolName;
  final String barcode;

  ToolCard(this.toolName, this.barcode);

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
              subtitle: Text(barcode),
            ),
          ],
        ),
      ),
    );
  }
}
