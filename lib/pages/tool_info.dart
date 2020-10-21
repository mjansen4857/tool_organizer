import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tool_organizer/objects/lendable_tool.dart';
import 'package:tool_organizer/objects/tool.dart';
import 'package:tool_organizer/services/database.dart';

class ToolInfo extends StatefulWidget {
  final Tool tool;

  ToolInfo(this.tool);

  @override
  State<StatefulWidget> createState() => _ToolInfoState();
}

class _ToolInfoState extends State<ToolInfo> {
  DateTime _selectedReturnDate;
  var _usernameController;

  @override
  void initState() {
    super.initState();
    _selectedReturnDate = DateTime.now();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

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
      body: buildListView(),
      floatingActionButton: !(widget.tool is LendableTool) ||
              (widget.tool as LendableTool).lentTo != null
          ? null
          : FloatingActionButton(
              child: Icon(Icons.call_made),
              onPressed: () {
                _lendToolDialog(context);
              },
            ),
    );
  }

  Future<void> _lendToolDialog(BuildContext context) async {
    _selectedReturnDate = DateTime.now();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lend Tool'),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  buildUsernameInput(),
                  buildReturnDateInput(),
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
                  Database.lendTool(widget.tool.barcode,
                      _usernameController.text, _selectedReturnDate);
                  Database.getUserFullName(_usernameController.text)
                      .then((value) {
                    setState(() {
                      (widget.tool as LendableTool).lentTo = value;
                      (widget.tool as LendableTool).requiredReturnDate =
                          _selectedReturnDate;
                    });
                  });
                  _usernameController.clear();
                },
              ),
            ],
          );
        });
  }

  Widget buildUsernameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.text,
        keyboardAppearance: Brightness.dark,
        cursorColor: Colors.white,
        controller: _usernameController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'Lendee Username',
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

  Widget buildReturnDateInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: RaisedButton(
        child: Text('Select Return Date'),
        onPressed: () {
          _selectDate(context);
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedReturnDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      helpText: 'SELECT RETURN DATE',
    );
    if (picked != null) {
      _selectedReturnDate = picked;
    }
  }

  Widget buildListView() {
    if (widget.tool is LendableTool) {
      return ListView(
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
          buildReturnDate(),
          Divider(),
          buildPurchaseDate(),
          Divider(),
          buildCategories(),
        ],
      );
    } else {
      return ListView(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: <Widget>[
          buildToolName(),
          Divider(),
          buildBarcode(),
          Divider(),
          buildOwner(),
          Divider(),
          buildPurchaseDate(),
          Divider(),
          buildCategories(),
        ],
      );
    }
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
          widget.tool.toolName,
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
          widget.tool.barcode,
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
          widget.tool.owner,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildLendee() {
    var tool = widget.tool as LendableTool;
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
          (tool.lentTo) != null ? tool.lentTo : 'Not Lent',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildReturnDate() {
    var tool = widget.tool as LendableTool;
    return Row(
      children: <Widget>[
        Text(
          'Required Return Date:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          (tool.requiredReturnDate) != null
              ? tool.requiredReturnDate.toString()
              : 'Not Lent',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget buildPurchaseDate() {
    return Row(
      children: <Widget>[
        Text(
          'Purchase Date:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          widget.tool.purchaseDate.toString(),
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
          children: createCategoryChips(),
        ),
      ],
    );
  }

  List<Widget> createCategoryChips() {
    List<Widget> chips = [];

    for (var cat in widget.tool.categories) {
      chips.add(Chip(
        label: Text(cat),
      ));
    }

    return chips;
  }
}
