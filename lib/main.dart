import 'package:flutter/material.dart';
import 'package:tool_organizer/pages/root_page.dart';

void main() {
  runApp(ToolOrganizer());
}

class ToolOrganizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tool Organizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigo,
      ),
      home: RootPage(),
    );
  }
}
