import 'package:spa_flutter_cli/exp_library.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getUserDetails(String userId) async {
  ApiResponse _apiResponse = ApiResponse();
  try {
    var url = new Uri.http(Env.baseUrl, "users/" + userId);

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