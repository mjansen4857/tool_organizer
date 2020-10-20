import 'package:flutter/material.dart';

class ToolInfo extends StatefulWidget {
  final String barcode;

  ToolInfo(this.barcode);

  @override
  State<StatefulWidget> createState() => _ToolInfoState();
}

class _ToolInfoState extends State<ToolInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tool Info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          children: <Widget>[
            buildToolName(),
            Divider(),
            buildBarcode(),
            Divider(),
            buildOwner(),
            Divider(),
            buildLendee(),
            Divider(),
            buildCategories(),
          ],
        ),
      ),
    );
  }

  Widget buildToolName() {
    return Row(
      children: <Widget>[
        Text(
          'Tool Name:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          'Some Name',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildBarcode() {
    return Row(
      children: <Widget>[
        Text(
          'Barcode:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          widget.barcode,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildOwner() {
    return Row(
      children: <Widget>[
        Text(
          'Owner:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          'Some Person',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildLendee() {
    return Row(
      children: <Widget>[
        Text(
          'Lent To:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          'Some Person',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Categories:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Wrap(
          spacing: 6,
          runSpacing: -8,
          children: <Widget>[
            Chip(
              label: Text('Hand Tool'),
            ),
            Chip(
              label: Text('Power Tool'),
            ),
            Chip(
              label: Text('Saw'),
            ),
            Chip(
              label: Text('Drill'),
            ),
            Chip(
              label: Text('Wrench'),
            ),
            Chip(
              label: Text('Screwdriver'),
            ),
            Chip(
              label: Text('Hammer'),
            ),
          ],
        ),
      ],
    );
  }
}
