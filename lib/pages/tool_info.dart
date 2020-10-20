import 'dart:async';

import 'package:flutter/material.dart';

class ToolInfo extends StatefulWidget {
  final String barcode;

  ToolInfo(this.barcode);

  @override
  State<StatefulWidget> createState() => _ToolInfoState();
}

class _ToolInfoState extends State<ToolInfo> {
  bool _isLoading = true;
  bool _lendable = true;
  bool _isLent = true;
  DateTime _selectedReturnDate;
  var _usernameController;

  @override
  void initState() {
    super.initState();
    _selectedReturnDate = DateTime.now();
    _usernameController = TextEditingController();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
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
      body: Stack(
        children: <Widget>[
          buildListView(),
          buildLoading(),
        ],
      ),
      floatingActionButton: (!_lendable) || _isLent
          ? null
          : FloatingActionButton(
              child: Icon(Icons.call_made),
              onPressed: () {
                _lendToolDialog(context);
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
                  print(_usernameController.text);
                  print(_selectedReturnDate);
                  //TODO stuff
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
    if (_isLoading) {
      return Container(
        height: 0,
        width: 0,
      );
    }
    if (_lendable) {
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

  Widget buildReturnDate() {
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
          'Some Date',
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
          'Some Date',
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
