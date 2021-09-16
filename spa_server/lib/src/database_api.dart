/* import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:objectid/objectid.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:collection/collection.dart';
*/
import 'package:spa_server/spa_server.dart';

class dbSqlite_api {
  String DatabasesPath = '';
  String DatabaseName = '';

  late final Database MyDatabase;

    dbSqlite_api(DatabaseName) {
    this.DatabaseName = DatabaseName;
   openDB() ;

  }

  Future<Database> openDB() async {
    //  DatabasesPath = await getDatabasesPath();
    //   String path = join(DatabasesPath, DatabaseName);
    print(' Open Data BAse : ' + DatabaseName);
    open.overrideFor(OperatingSystem.linux, _openSqlit3OnLinux);
    //database = sqlite3.openInMemory();
    MyDatabase  = sqlite3.open(DatabaseName);
    var  stmt;

    try {
         stmt = MyDatabase.prepare(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY, email  TEXT, password TEXT, _id TEXT , salt TEXT)');

      stmt.execute();
      print('created table USers');
      stmt.dispose();
   } catch (error) {
     print(' Table Users  Already exist ' + error.toString());
    }

    try {
    stmt = MyDatabase.prepare('INSERT INTO Users (  _id , id  , email  , password  , salt  ) VALUES (?,?,?,?,?)');
    stmt.execute([ObjectId().toString(), 1, 'kflihan@kflihan.com', "123456",  "etertert"]);
    stmt.dispose();
    } catch (error) {
      print(' recored already inserted  ' + error.toString());
    }

    final ResultSet resultSet = MyDatabase.select('SELECT * FROM users ');
    resultSet.forEach((element) {
      print(element);
    });

    return (MyDatabase);
  }
}

DynamicLibrary _openSqlit3OnLinux() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  print(scriptDir);
  final libraryNextToScript = File('${scriptDir.path}/libsqlite3.so');
  return DynamicLibrary.open(libraryNextToScript.path);
}

// Get a location using getDatabasesPath
//var databasesPath = await getDatabasesPath();
//String path = join(databasesPath, 'demo.db');

// Delete the database
//await deleteDatabase(path);

// Insert some records in a transaction
/*
await database.transaction((txn) async {
int id1 = await txn.rawInsert(
'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
print('inserted1: $id1');
int id2 = await txn.rawInsert(
'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
['another name', 12345678, 3.1416]);
print('inserted2: $id2');
});
*/

// Update some record
/*
int count = await database.rawUpdate(
'UPDATE Test SET name = ?, value = ? WHERE name = ?',
['updated name', '9876', 'some name']);
print('updated: $count');
*/

// Get the records
/*
Future<List<Map>> findOneUSer(Database spaDatabase, String email) async {
  List<Map> list = await spaDatabase
      .rawQuery('SELECT user FROM Users where Email =' + email);
//List<Map> expectedList = [
//  {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
  // {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
//];

  print(list);

  return (list);
//print(expectedList);
//assert(const DeepCollectionEquality().equals(list, expectedList));
}
*/
// Count the records
/*
count = Sqflite
    .firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Test'));
assert(count == 2);
*/

// Delete a record
/*
count = await database
    .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
assert(count == 1);
*/
// Close the database
//await database.close();
