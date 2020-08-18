import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directiory = await getApplicationDocumentsDirectory();
    var path = join(directiory.path, 'db_affirmaily_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDB);
    return database;
  }

  _onCreatingDB(Database database, int version) async {
    await database.execute(
        "CREATE TABLE affirmations(id INTEGER PRIMARY KEY, body TEXT)");
  }
}
