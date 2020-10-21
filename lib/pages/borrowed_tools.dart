import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/services/database.dart';
import 'package:tool_organizer/widgets/tool_card.dart';

class BorrowedTools extends StatefulWidget {
  final String username;

  BorrowedTools({this.username});

  @override
  State<StatefulWidget> createState() => _BorrowedToolsState();
}

class _BorrowedToolsState extends State<BorrowedTools> {
  bool _isLoading = true;
  List<Widget> _toolCards = [];

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Database.getBorrowedTools(widget.username).then((value) {
      List<Widget> tools = [];

      for (var tool in value) {
        tools.add(ToolCard(tool));
      }

      setState(() {
        _toolCards = tools;
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
