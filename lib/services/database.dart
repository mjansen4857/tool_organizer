import 'dart:async';

import 'package:postgres/postgres.dart';

class Database {
  static final PostgreSQLConnection connection = PostgreSQLConnection(
      'reddwarf.cs.rit.edu', 5432, 'p320_29',
      username: 'p320_29', password: 'eeR5ahLiejaD4aeceiy1', useSSL: true);

  Future<void> openConnection() async {
    print('[DB Service] Attempting to open DB connection: ' + connection.host);
    await connection.open();
    print('[DB Service] Connection to DB opened.');
  }

  Future<String> getUserFullName(String username) async {
    List<List<dynamic>> results = await connection.query(
        'SELECT first_name, last_name FROM public.users WHERE username = @username',
        substitutionValues: {'username': username});

    if (results.isEmpty) {
      return null;
    }
    return results[0][0] + ' ' + results[0][1];
  }
}
