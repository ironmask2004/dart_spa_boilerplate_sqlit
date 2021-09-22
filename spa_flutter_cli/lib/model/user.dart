/// id : "6144eb3df4fe4c649dbcd39a"
/// email : "melocalco32"
/// password : "9323d01a9da861564b93e6b73154bdeb632880f158f74fc5764520381549ae81"
/// salt : "CXvGYr7MzMTw7Kv3mVLL9AIjTmv7Kok7RKQXVz8sf1I"

import 'package:spa_flutter_cli/exp_library.dart';
import 'package:http/http.dart' as http;

class User {
  User._User({
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

  User._fromJson(dynamic json) {
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

  Future<ApiResponse> getUserDetails(String userId) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      var url = new Uri.http(Env.baseUrl, "user/" + userId);

      // final response = await http.get('${_baseUrl}user/$userId');

      final client = http.Client();
      final http.Response response =
          await client.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      switch (response.statusCode) {
        case 200:
          _apiResponse.Data = User.fromJson(json.decode(response.body));
          break;
        case 401:
          print((_apiResponse.ApiError as ApiError).error);
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          print((_apiResponse.ApiError as ApiError).error);
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }
}
