import 'package:spa_flutter_cli/exp_library.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

/*
curl --location --request GET 'localhost:9093/users/' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MzIyNTQzMjksImV4cCI6MTYzMjI1NDQ1OSwic3ViIjoiNjE0OGRmM2M1NWE5NjQ2NzdiNDMxOGZiIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdCIsImp0aSI6IjMyYTBmODllLTY3YTItNDgyZC1iZmUzLTMzMzQzYjRjNjMwYiJ9.KQyxOPodML_Zqam7LKGauYCJ0IBqlXKCfjiuGu3WIII'
 */

Future<Either<ApiResponse, User>> getUserInfo(String userId) async {
  ApiResponse _apiResponse = ApiResponse();
  try {
    var url = Uri.http(Env.baseUrl, "users/info/");
    Map<String, String> _headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer $userId'
    };
    final client = http.Client();
    final http.Response response = await client.get(url, headers: _headers);
    final _response = response.statusCode;

    if (_response == 200) {
      _apiResponse.Data = User.fromJson(response.body);
      _apiResponse.ApiError = ApiError.fromJson(
          {"error": "Get User Info Success", "errorNo": "200"});
      return right(_apiResponse.Data as User);
    } else {
      _apiResponse.ApiError = ApiError(
          error: json.decode(response.body), errorNo: _response.toString());
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(
        error: "Server SocketException error. Please retry",
        errorNo: "1999991");
  }
  return left(_apiResponse);
}

/*
--header 'Content-Type: application/json' \
--data-raw '{"email": "melocalcom1" , "password": "123456"}'
 */

Future<Either<ApiResponse, User>> loginUser(
    String email, String password) async {
  ApiResponse _apiResponse = ApiResponse();
  try {
    final _url = Uri.parse('http://' + Env.baseUrl + "/auth/login");
    final _headers = {"Content-type": "application/json"};
    final _json = '{ \"email\": \"$email\" ,  \"password\": \"$password\" }';
    final http.Response response =
        await http.post(_url, headers: _headers, body: _json);
    if (response.statusCode == 200) {
      final String _token = json.decode(response.body)['token'];
      _apiResponse.Data = User.fromJson(
          '{\"id\": \"$_token\", \"email\": \"$email\" ,  \"password\": \"$password\" }');
      _apiResponse.ApiError = ApiError(error: "Login suscess", errorNo: "200");
      return right(_apiResponse.Data as User);
    } else {
      _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
    }
  } on SocketException {
    _apiResponse.ApiError =
        ApiError(error: "Server error. Please retry", errorNo: "199991");
  }
  return left(_apiResponse);
}

Future<Either<ApiResponse, String>> logOutUser(String userId) async {
  ApiResponse _apiResponse = ApiResponse();
  try {
    var url = new Uri.http(Env.baseUrl, "users/logout");
    Map<String, String> _headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer $userId'
    };
    print(url.toString() + " Headrs:  " + _headers.toString());
    final client = http.Client();
    final http.Response response = await client.post(url, headers: _headers);
    final _response = response.statusCode;
    print("LLLLLLLLLLLLLLLLLLLLLLogout + error $_response");

    if (_response == 200) {
      // _apiResponse.Data = User.fromJson(response.body);
      _apiResponse.ApiError = ApiError.fromJson(
          {"error": "Get User LogOut Success", "errorNo": "200"});
      return right("Get User LogOut Success");
    } else {
      _apiResponse.ApiError = ApiError(
          error: json.decode(response.body), errorNo: _response.toString());
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(
        error: "Server SocketException error. Please retry",
        errorNo: "1999991");
  }
  return left(_apiResponse);
}
