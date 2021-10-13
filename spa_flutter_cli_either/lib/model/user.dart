/// id : "6144eb3df4fe4c649dbcd39a"
/// email : "melocalco32"
/// password : "9323d01a9da861564b93e6b73154bdeb632880f158f74fc5764520381549ae81"
/// userType : "CXvGYr7MzMTw7Kv3mVLL9AIjTmv7Kok7RKQXVz8sf1I"

import 'package:spa_flutter_cli_either/exp_library.dart';
import 'package:http/http.dart' as http;

class User {
  User._User(
      {String? id,
      String? email,
      String? password,
      String? userType,
      String? refreshToken,
      String? token}) {
    _id = id;
    _email = email;
    _password = password;
    _userType = (userType == null ? 'User' : userType);
    _refreshToken = refreshToken;
    _token = token;
  }

  // User(){ }

  User.fromJson(dynamic _json) {
    print('from Jeson===== ' + _json.toString());
    _id = json.decode(_json)['id'].toString();
    _email = json.decode(_json)['email'];
    _password = json.decode(_json)['password'];
    _userType = 'user'; // json['userType'];
    _token = json.decode(_json)['token'];
    _refreshToken = json.decode(_json)['refreshToken'];

    print('User from Json------------: ' + User.toJson().toString());
    print('end from jeson------------');
  }
  User.fromJsonwithoutToken(dynamic _json, String token, String refreshToken) {
    print('from Jeson-=-=-=-=-=-= ' + _json.toString());

    print(_json.runtimeType);

    //print(json.decode(_json)['id'].toString());
    print('ttotototken refresh' + refreshToken);
    print('totototoken:' + token);
    _id = json.decode(_json)['id'].toString();
    print('id:' + _id!);
    _email = json.decode(_json)['email'];
    print('email:' + _email!);
    _password = json.decode(_json)['password'];
    print('passwrod:' + _password!);
    ;
    _userType = 'user'; // json['userType'];
    _refreshToken = refreshToken;
    _token = token;

    print('fromJsonwithoutToken : ' + User.toJson().toString());
    print('fromJsonwithoutToken');
  }

  User._fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _password = json['password'];
    _userType = 'user'; // json['userType'];
    print('User to Json:' + User.toJson().toString());
  }

  static String? _id;
  static String? _email;
  static String? _password;
  static String? _userType;
  static String? _refreshToken;
  static String? _token;

  static String? get id => _id;
  static String? get email => _email;
  static String? get password => _password;
  static String? get userType => _userType;
  static String? get refreshToken => _refreshToken;
  static String? get token => _token;

  static void set id(String? id) {
    _id = id;
  }

  static void set refreshToken(String? refreshToken) {
    _refreshToken = refreshToken;
  }

  static void set token(String? token) {
    _token = token;
  }

  static void set email(String? email) {
    _email = email;
  }

  static void set password(String? password) {
    _password = password;
  }

  static void set userType(String? userType) {
    _userType = userType;
  }

  static Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['password'] = _password;
    map['userType'] = _userType;
    map['refreshToken'] = _refreshToken;
    map['token'] = _token;
    print('Userr to Jeson:' + map.toString());
    return map;
  }
}
