import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/widgets/tool_card.dart';

class BorrowedTools extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BorrowedToolsState();
}

class _BorrowedToolsState extends State<BorrowedTools> {
  bool _isLoading = true;
  List<Widget> _toolCards = [
    ToolCard('Borrowed Tool 1', 'Return Date: 1/10/20', '6'),
    ToolCard('Borrowed Tool 2', 'Return Date: 1/11/20', '7'),
    ToolCard('Borrowed Tool 3', 'Return Date: 1/12/20', '8'),
    ToolCard('Borrowed Tool 4', 'Return Date: 1/13/20', '9'),
    ToolCard('Borrowed Tool 5', 'Return Date: 1/14/20', '10'),
  ];

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
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
}
