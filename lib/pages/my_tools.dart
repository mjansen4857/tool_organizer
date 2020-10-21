import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/objects/lendable_tool.dart';
import 'package:tool_organizer/objects/tool.dart';
import 'package:tool_organizer/services/database.dart';
import 'package:tool_organizer/widgets/tool_card.dart';

class MyTools extends StatefulWidget {
  final Database db;
  final String username;
  final String fullname;

  MyTools({this.db, this.username, this.fullname});

  @override
  State<StatefulWidget> createState() => _MyToolsState();
}

class _MyToolsState extends State<MyTools> {
  bool _isLoading = true;
  var _toolNameController;
  var _barcodeController;
  bool _lendableSelected = false;
  List<Widget> _toolCards = [];

  bool _handToolSelected = false;
  bool _powerToolSelected = false;
  bool _sawSelected = false;
  bool _drillSelected = false;
  bool _screwdriverSelected = false;
  bool _hammerSelected = false;
  bool _wrenchSelected = false;

  @override
  void initState() {
    super.initState();
    _toolNameController = TextEditingController();
    _barcodeController = TextEditingController();
    _isLoading = true;
    Database.getOwnedTools(widget.username).then((value) {
      List<ToolCard> tools = [];

      for (var tool in value) {
        tools.add(ToolCard(tool));
      }

      setState(() {
        _toolCards = tools;
        _isLoading = false;
      });
    });
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
    _toolNameController.clear();
    _barcodeController.clear();
    _lendableSelected = false;
    _handToolSelected = false;
    _powerToolSelected = false;
    _sawSelected = false;
    _drillSelected = false;
    _screwdriverSelected = false;
    _hammerSelected = false;
    _wrenchSelected = false;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text('Add Tool'),
                content: Container(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      buildToolNameInput(),
                      buildBarcodeInput(),
                      buildCategoriesInput(setState2),
                      buildLendableInput(setState2),
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
                      String toolName = _toolNameController.text;
                      String barcode = _barcodeController.text;
                      bool lendable = _lendableSelected;
                      List<String> categories = [];
                      if (_handToolSelected) categories.add('Hand Tool');
                      if (_powerToolSelected) categories.add('Power Tool');
                      if (_sawSelected) categories.add('Saw');
                      if (_drillSelected) categories.add('Drill');
                      if (_screwdriverSelected) categories.add('Screwdriver');
                      if (_hammerSelected) categories.add('Hammer');
                      if (_wrenchSelected) categories.add('Wrench');

                      Tool tool;

                      if (lendable) {
                        tool = LendableTool(toolName, barcode, widget.fullname,
                            DateTime.now(), categories, null, null);
                      } else {
                        tool = Tool(toolName, barcode, widget.fullname,
                            DateTime.now(), categories);
                      }

                      Database.addTool(widget.username, tool);

                      setState(() {
                        _toolCards = [..._toolCards, ToolCard(tool)];
                      });
                    },
                  ),
                ],
              );
            },
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

  Widget buildLendableInput(Function(VoidCallback) setState) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: <Widget>[
          Switch(
            value: _lendableSelected,
            onChanged: (bool value) {
              setState(() {
                _lendableSelected = value;
              });
            },
          ),
          Text('Lendable'),
          // SizedBox(
          //   width: 150,
          // ),
        ],
      ),
    );
    return SwitchListTile(
      title: Text('Lendable'),
      value: _lendableSelected,
      onChanged: (bool value) {
        setState(() {
          _lendableSelected = value;
        });
      },
    );
  }

  Widget buildCategoriesInput(Function(VoidCallback) setState) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Align(
              alignment: Alignment.topLeft, child: Text('Choose Categories')),
        ),
        Center(
          child: Wrap(
            spacing: 8,
            children: <Widget>[
              FilterChip(
                label: Text('Hand Tool'),
                selected: _handToolSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _handToolSelected = selected;
                  });
                },
              ),
              FilterChip(
                label: Text('Power Tool'),
                selected: _powerToolSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _powerToolSelected = selected;
                  });
                },
              ),
              FilterChip(
                label: Text('Saw'),
                selected: _sawSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _sawSelected = selected;
                  });
                },
              ),
              FilterChip(
                label: Text('Drill'),
                selected: _drillSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _drillSelected = selected;
                  });
                },
              ),
              FilterChip(
                label: Text('Screwdriver'),
                selected: _screwdriverSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _screwdriverSelected = selected;
                  });
                },
              ),
              FilterChip(
                label: Text('Hammer'),
                selected: _hammerSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _hammerSelected = selected;
                  });
                },
              ),
              FilterChip(
                label: Text('Wrench'),
                selected: _wrenchSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _wrenchSelected = selected;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
