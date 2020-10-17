import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/widgets/tool_card.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var _toolNameController;
  var _barcodeController;
  List<Widget> _toolCards = [
    ToolCard('Test Tool 1', '1'),
    ToolCard('Test Tool 2', '2'),
    ToolCard('Test Tool 3', '3'),
    ToolCard('Test Tool 4', '4'),
    ToolCard('Test Tool 5', '5'),
  ];

  @override
  void initState() {
    super.initState();
    _toolNameController = TextEditingController();
    _barcodeController = TextEditingController();
  }

  @override
  void dispose() {
    _toolNameController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: _toolCards,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addToolDialog(context);
        },
      ),
    );
  }

  Future<void> _addToolDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Tool'),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  buildToolNameInput(),
                  buildBarcodeInput(),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'CONFIRM',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                  setState(() {
                    _toolCards = [
                      ..._toolCards,
                      ToolCard(
                          _toolNameController.text, _barcodeController.text)
                    ];
                  });
                  _toolNameController.clear();
                  _barcodeController.clear();
                },
              ),
            ],
          );
        });
  }

  Widget buildToolNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        cursorColor: Colors.white,
        controller: _toolNameController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Tool Name',
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey[400],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }

  Widget buildBarcodeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        cursorColor: Colors.white,
        controller: _barcodeController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Barcode',
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.grey[400],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
