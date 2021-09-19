/// id : "6144eb3df4fe4c649dbcd39a"
/// email : "melocalco32"
/// password : "9323d01a9da861564b93e6b73154bdeb632880f158f74fc5764520381549ae81"
/// salt : "CXvGYr7MzMTw7Kv3mVLL9AIjTmv7Kok7RKQXVz8sf1I"
import 'package:spa_server/spa_server.dart';

class User {
  User({
    String? id,
    String? email,
    String? password,
    String? salt,
  }) {
    _id = id;
    _email = email;
    _password = password;
    _salt = salt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _password = json['password'];
    _salt = json['salt'];
  }
  String? _id;
  String? _email;
  String? _password;
  String? _salt;

  String? get id => _id;
  String? get email => _email;
  String? get password => _password;
  String? get salt => _salt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['password'] = _password;
    map['salt'] = _salt;
    return map;
  }

  Future<String> findOneByID(String id, Database db) async {
    final ResultSet resultSet =
        db.select('SELECT * FROM Users WHERE id = \"' + id + "\"");
    if (resultSet.isEmpty) {
      return ("NULL");
    }
    print(resultSet.toString());
    return (   await ({
      'id': resultSet.first['id'],
      'email': resultSet.first['email'],
      'salt': resultSet.first['salt'],
      'password': resultSet.first['password'],
    }).toString()

    ) ;

  }
}
