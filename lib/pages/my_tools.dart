import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/widgets/tool_card.dart';

class MyTools extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyToolsState();
}

class _MyToolsState extends State<MyTools> {
  bool _isLoading = true;
  var _toolNameController;
  var _barcodeController;
  List<Widget> _toolCards = [
    ToolCard('My Tool 1', 'Barcode: 1', '1'),
    ToolCard('My Tool 2', 'Barcode: 2', '2'),
    ToolCard('My Tool 3', 'Barcode: 3', '3'),
    ToolCard('My Tool 4', 'Barcode: 4', '4'),
    ToolCard('My Tool 5', 'Barcode: 5', '5'),
  ];

  @override
  void initState() {
    super.initState();
    _toolNameController = TextEditingController();
    _barcodeController = TextEditingController();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
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
      body: Stack(
        children: <Widget>[
          Center(
            child: ListView(
              padding: EdgeInsets.all(5),
              children: _toolCards,
            ),
          ),
          buildLoading(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addToolDialog(context);
        },
      ),
    );
  }

  Widget buildLoading() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0,
      width: 0,
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
                          _toolNameController.text,
                          'Barcode: ' + _barcodeController.text,
                          _barcodeController.text)
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
