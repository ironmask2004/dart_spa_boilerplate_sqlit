import 'package:spa_server/spa_server.dart';
/*
Future<String> fetchData() async {
  final response = await http.get('http://webcode.me');

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch data');
  }
}

void main() async {
  var data = await fetchData();
  print(data);
}
 */

Future<String> findUserByID(String id, Database db) async {
  final ResultSet resultSet =
  db.select('SELECT * FROM Users WHERE id = \"' + id + "\"");
  if (resultSet.isNotEmpty) {
    print("++++++++:" + resultSet.toString());
  /* return (await ({
      'id': resultSet.first['id'],
      'email': resultSet.first['email'],
      'salt': resultSet.first['salt'],
      'password': resultSet.first['password'],
    }).toString());*/

    return    ( await resultSet.toString());
  } else
    print( ' User ID($id) Not Found ');
    throw ' User ID($id) Not Found ';
}
