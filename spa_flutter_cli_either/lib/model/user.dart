/// id : "6144eb3df4fe4c649dbcd39a"
/// email : "melocalco32"
/// password : "9323d01a9da861564b93e6b73154bdeb632880f158f74fc5764520381549ae81"
/// userType : "CXvGYr7MzMTw7Kv3mVLL9AIjTmv7Kok7RKQXVz8sf1I"

import 'package:spa_flutter_cli/exp_library.dart';
import 'package:http/http.dart' as http;

class User {
  User._User({
    String? id,
    String? email,
    String? password,
    String? userType,
  }) {
    _id = id;
    _email = email;
    _password = password;
    _userType =(  userType ==null ?  'User' : userType) ;
  }

  // User(){ }

  User.fromJson(dynamic _json) {
    print('from Jeson ' + _json.toString());
    // print('id:' + _json['id']);
    _id = json.decode(_json)['id'];
    //   print('email:' + _json['email']);
    _email = json.decode(_json)['email'];
    //   print('password:' + _json['password']);
    _password = json.decode(_json)['password'];
    _userType = 'user'; // json['userType'];
    print('end from jeson');
  }

 User._fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _password = json['password'];
    _userType = 'user'; // json['userType'];
  }

  static String? _id;
  static String? _email;
  static String? _password;
  static String? _userType;

  static String? get  id => _id;
  static String? get email => _email;
  static  String? get password => _password;
  static  String? get userType => _userType;

  static void set id(String? id) {  _id = id;}
  static void set email(String? email) {  _email = email;}
  static void set password(String? password) {  _password = password;}
  static void set userType(String? userType) {  _userType = userType;}

  static Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['password'] = _password;
    map['userType'] = _userType;
    return map;
  }
}
