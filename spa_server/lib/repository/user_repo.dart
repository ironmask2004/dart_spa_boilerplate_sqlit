import 'package:spa_server/spa_server.dart';

Future<User> findUserByID(String id, Database db) async {
  final resultSet = db.select('SELECT * FROM Users WHERE id = \"' + id + '\"');
  if (resultSet.isNotEmpty) {
    return User.fromJson(resultSet.first);
  } else {
    print(' User ID($id) Not Found ');
    throw ' User ID($id) Not Found ';
  }
}

Future<List<User>> findUserAll(Database db) async {
  List<User> resultUsers = <User>[];
  final resultSet = db.select('SELECT * FROM Users ');
  if (resultSet.isNotEmpty) {
    resultSet.forEach((element) {
      // print(element);
      resultUsers.add(User.fromJson(element));
    });

    return (resultUsers);
  } else {
    print(' Users is Empty ');
    throw ' Users is Empty ';
  }
}
