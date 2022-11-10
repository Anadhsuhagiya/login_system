import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Model
{
      Future<Database> createDatabse()
      async {
            // Get a location using getDatabasesPath
            var databasesPath = await getDatabasesPath();
            String path = join(databasesPath, 'login_system.db');

            // open the database
            Database database = await openDatabase(path, version: 1,
                onCreate: (Database db, int version) async {
                      // When creating the db, create the table
                      await db.execute(
                          'CREATE TABLE Register (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT , contact TEXT, password TEXT, con_pass TEXT, birthdate TEXT)');
                });

            return database;
      }
}
