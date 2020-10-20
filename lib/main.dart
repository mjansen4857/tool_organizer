import 'package:flutter/material.dart';
import 'package:tool_organizer/pages/root_page.dart';
import 'package:tool_organizer/services/database.dart';

void main() {
  runApp(ToolOrganizer());
}

class ToolOrganizer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tool Organizer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigo,
      ),
      home: RootPage(
        db: Database(),
      ),
    );
  }
}
