import 'dart:async';

import 'package:postgres/postgres.dart';
import 'package:tool_organizer/objects/lendable_tool.dart';
import 'package:tool_organizer/objects/tool.dart';

class Database {
  static final PostgreSQLConnection connection = PostgreSQLConnection(
      'reddwarf.cs.rit.edu', 5432, 'p320_29',
      username: 'p320_29', password: 'eeR5ahLiejaD4aeceiy1', useSSL: true);

  static Future<void> closeConnection() async {
    await connection.close();
  }

  static Future<void> openConnection() async {
    print('[DB Service] Attempting to open DB connection: ' + connection.host);
    await connection.open();
    print('[DB Service] Connection to DB opened.');
  }

  static Future<String> getUserFullName(String username) async {
    List<List<dynamic>> results = await connection.query(
        'SELECT first_name, last_name FROM public.users WHERE username = @username',
        substitutionValues: {'username': username});

    if (results.isEmpty) {
      return null;
    }
    return results[0][0] + ' ' + results[0][1];
  }

  static Future<List<Tool>> getOwnedTools(String username) async {
    List<List<dynamic>> tool_results = await connection.query(
        'SELECT barcode, name, purchase_date FROM public.tools WHERE username = @username AND removed_date IS NULL',
        substitutionValues: {'username': username});

    List<Tool> tools = [];
    String userFullname = await getUserFullName(username);

    for (var result in tool_results) {
      String barcode = result[0];
      String name = result[1];
      DateTime purchaseDate = result[2];
      List<String> categories = [];

      List<List<dynamic>> cat_results = await connection.query(
          'SELECT category FROM public.tool_categories WHERE barcode = @barcode',
          substitutionValues: {'barcode': barcode});

      for (var cat in cat_results) {
        categories.add(cat[0]);
      }

      List<List<dynamic>> lendable_result = await connection.query(
          'SELECT barcode FROM public.lendable_tools WHERE barcode = @barcode',
          substitutionValues: {'barcode': barcode});

      if (lendable_result.isNotEmpty) {
        String lentTo = null;
        DateTime requiredReturnDate = null;

        List<List<dynamic>> lending_info_result = await connection.query(
            'SELECT username, required_return_date FROM public.lent_to WHERE barcode = @barcode',
            substitutionValues: {'barcode': barcode});

        if (lending_info_result.isNotEmpty) {
          lentTo = await getUserFullName(lending_info_result[0][0]);
          requiredReturnDate = lending_info_result[0][1];
        }

        tools.add(LendableTool(name, barcode, userFullname, purchaseDate,
            categories, lentTo, requiredReturnDate));
      } else {
        tools.add(Tool(name, barcode, userFullname, purchaseDate, categories));
      }
    }

    return tools;
  }

  static Future<List<LendableTool>> getBorrowedTools(String username) async {
    List<List<dynamic>> tool_results = await connection.query(
        'SELECT barcode, required_return_date FROM public.lent_to WHERE username = @username',
        substitutionValues: {'username': username});

    List<LendableTool> tools = [];
    String userFullname = await getUserFullName(username);

    for (var result in tool_results) {
      String barcode = result[0];
      DateTime requiredReturnDate = result[1];
      List<String> categories = [];

      List<List<dynamic>> cat_results = await connection.query(
          'SELECT category FROM public.tool_categories WHERE barcode = @barcode',
          substitutionValues: {'barcode': barcode});

      for (var cat in cat_results) {
        categories.add(cat[0]);
      }

      List<List<dynamic>> tool_info_results = await connection.query(
          'SELECT name, purchase_date, username FROM public.tools WHERE barcode = @barcode',
          substitutionValues: {'barcode': barcode});

      String name = tool_info_results[0][0];
      DateTime purchaseDate = tool_info_results[0][1];
      String ownerName = await getUserFullName(tool_info_results[0][2]);

      tools.add(LendableTool(name, barcode, ownerName, purchaseDate, categories,
          userFullname, requiredReturnDate));
    }

    return tools;
  }

  static Future<void> addTool(String username, Tool tool) async {
    await connection.query(
        'INSERT INTO tools (barcode, name, purchase_date, username) VALUES (@barcode, @name, @purchase_date, @username)',
        substitutionValues: {
          'barcode': tool.barcode,
          'name': tool.toolName,
          'purchase_date': tool.purchaseDate,
          'username': username
        });

    for (var cat in tool.categories) {
      await connection.query(
          'INSERT INTO tool_categories (barcode, category) VALUES (@barcode, @category)',
          substitutionValues: {'barcode': tool.barcode, 'category': cat});
    }

    if (tool is LendableTool) {
      await connection.query(
          'INSERT INTO lendable_tools (barcode) VALUES (@barcode)',
          substitutionValues: {'barcode': tool.barcode});
    } else {
      await connection.query(
          'INSERT INTO non_lendable_tools (barcode) VALUES (@barcode)',
          substitutionValues: {'barcode': tool.barcode});
    }
  }

  static Future<void> lendTool(String barcode, String lendeeUsername,
      DateTime requiredReturnDate) async {
    await connection.query(
        'INSERT INTO lent_to (barcode, username, date_lent, required_return_date) VALUES (@barcode, @username, @date_lent, @required_return_date)',
        substitutionValues: {
          'barcode': barcode,
          'username': lendeeUsername,
          'date_lent': DateTime.now(),
          'required_return_date': requiredReturnDate
        });
  }

  static Future<void> removeTool(String barcode) async {
    await connection.query(
        'UPDATE tools SET removed_date = @date WHERE barcode = @barcode',
        substitutionValues: {'date': DateTime.now(), 'barcode': barcode});
  }
}
