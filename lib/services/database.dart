import 'package:postgres/postgres.dart';

class Database {
  final PostgreSQLConnection connection = PostgreSQLConnection(
      'reddwarf.cs.rit.edu', 5432, 'p320_29',
      username: 'p320_29', password: 'eeR5ahLiejaD4aeceiy1', useSSL: true);

  Future<void> openConnection() async {
    print('[DB Service] Attempting to open DB connection: ' + connection.host);
    await connection.open();
    print('[DB Service] Connection to DB opened.');
  }
}
