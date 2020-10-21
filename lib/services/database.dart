import 'dart:async';

import 'package:postgres/postgres.dart';
import 'package:tool_organizer/objects/lendable_tool.dart';
import 'package:tool_organizer/objects/tool.dart';

class Database {
  static final PostgreSQLConnection connection = PostgreSQLConnection(
      'reddwarf.cs.rit.edu', 5432, 'p320_29',
      username: 'p320_29', password: 'eeR5ahLiejaD4aeceiy1', useSSL: true);

  static Future<void> openConnection() async {
    print('[DB Service] Attempting to open DB connection: ' + connection.host);
    // await connection.open();
    print('[DB Service] Connection to DB opened.');
  }

  static Future<String> getUserFullName(String username) async {
    return 'Testing';
    List<List<dynamic>> results = await connection.query(
        'SELECT first_name, last_name FROM public.users WHERE username = @username',
        substitutionValues: {'username': username});

    if (results.isEmpty) {
      return null;
    }
    return results[0][0] + ' ' + results[0][1];
  }

  static Future<List<Tool>> getOwnedTools(String username) async {
    return Future.delayed(Duration(seconds: 1)).then((value) {
      var categories = [
        'Hand Tool',
        'Power Tool',
        'Saw',
        'Drill',
        'Screwdriver'
      ];
      return [
        new Tool(
            'My Tool 1', '1', 'Some Name', DateTime(2020, 3, 10), categories),
        new Tool(
            'My Tool 2', '2', 'Some Name', DateTime(2020, 3, 10), categories),
        new LendableTool('My Tool 3', '3', 'Some Name', DateTime(2020, 3, 10),
            categories, null, null),
        new LendableTool('My Tool 4', '4', 'Some Name', DateTime(2020, 3, 10),
            categories, 'Some Other Name', DateTime(2021, 3, 10)),
      ];
    });
  }

  static Future<List<LendableTool>> getBorrowedTools(String username) async {
    return Future.delayed(Duration(seconds: 1)).then((value) {
      var categories = [
        'Hand Tool',
        'Power Tool',
        'Saw',
        'Drill',
        'Screwdriver'
      ];
      return [
        new LendableTool('My Tool 1', '1', 'Some Name', DateTime(2020, 3, 10),
            categories, 'Some Other Name', DateTime(2021, 3, 10)),
        new LendableTool('My Tool 2', '2', 'Some Name', DateTime(2020, 3, 10),
            categories, 'Some Other Name', DateTime(2021, 3, 10)),
        new LendableTool('My Tool 3', '3', 'Some Name', DateTime(2020, 3, 10),
            categories, 'Some Other Name', DateTime(2021, 3, 10)),
        new LendableTool('My Tool 4', '4', 'Some Name', DateTime(2020, 3, 10),
            categories, 'Some Other Name', DateTime(2021, 3, 10)),
      ];
    });
  }

  static Future<void> addTool(String username, Tool tool) async {}

  static Future<void> lendTool(String barcode, String lendeeUsername,
      DateTime requiredReturnDate) async {}
}
