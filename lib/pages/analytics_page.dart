import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_organizer/services/database.dart';

class AnalyticsPage extends StatefulWidget {
  final String username;

  AnalyticsPage({this.username});

  @override
  State<StatefulWidget> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  bool _isLoading = true;
  List<Card> _missingToolCards = [];
  List<Card> _myMostLentToolCards = [];
  List<Card> _biggestLenderCards = [];
  List<Card> _biggestBorrowerCards = [];
  List<Card> _biggestCollectionsCards = [];

  @override
  void initState() {
    super.initState();
    Database.getMissingToolCards(widget.username).then((missingTools) {
      Database.getMyMostLentToolCards(widget.username).then((myMostLentTools) {
        Database.getBiggestLenderCards().then((biggestLenders) {
          Database.getBiggestBorrowerCards().then((biggestBorrowers) {
            Database.getBiggestCollectionsCards().then((biggestCollections) {
              setState(() {
                _missingToolCards = missingTools;
                _myMostLentToolCards = myMostLentTools;
                _biggestLenderCards = biggestLenders;
                _biggestBorrowerCards = biggestBorrowers;
                _biggestCollectionsCards = biggestCollections;
                _isLoading = false;
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TabBarView(
          children: <Widget>[
            buildAnalyticsTab1(),
            buildAnalyticsTab2(),
            buildAnalyticsTab3(),
            buildAnalyticsTab4(),
            buildAnalyticsTab5(),
          ],
        ),
        buildLoading(),
      ],
    );
  }

  Widget buildAnalyticsTab1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Material(
          elevation: 5,
          color: Color(0xff343434),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Text(
                'Missing Tools',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
        Expanded(
          child: CupertinoScrollbar(
            child: ListView(
              padding: EdgeInsets.fromLTRB(3, 5, 3, 3),
              children: _missingToolCards,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnalyticsTab2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Material(
          elevation: 5,
          color: Color(0xff343434),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Text(
                'My Most Lent Tools',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
        Expanded(
          child: CupertinoScrollbar(
            child: ListView(
              padding: EdgeInsets.fromLTRB(3, 5, 3, 3),
              children: _myMostLentToolCards,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnalyticsTab3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Material(
          elevation: 5,
          color: Color(0xff343434),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Text(
                'Biggest Lenders',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
        Expanded(
          child: CupertinoScrollbar(
            child: ListView(
              padding: EdgeInsets.fromLTRB(3, 5, 3, 3),
              children: _biggestLenderCards,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnalyticsTab4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Material(
          elevation: 5,
          color: Color(0xff343434),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Text(
                'Biggest Borrowers',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
        Expanded(
          child: CupertinoScrollbar(
            child: ListView(
              padding: EdgeInsets.fromLTRB(3, 5, 3, 3),
              children: _biggestBorrowerCards,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnalyticsTab5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Material(
          elevation: 5,
          color: Color(0xff343434),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Text(
                'Biggest Collections',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
        ),
        Expanded(
          child: CupertinoScrollbar(
            child: ListView(
              padding: EdgeInsets.fromLTRB(3, 5, 3, 3),
              children: _biggestCollectionsCards,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoading() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
