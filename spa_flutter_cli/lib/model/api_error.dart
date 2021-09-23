import 'package:spa_flutter_cli/exp_library.dart';

class ApiError {
  late String _error;

  ApiError({required String error}) {
    this._error = error;
  }

  String get error => _error;
  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    print("----------------" + json.toString());
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this._error;
    return data;
  }
}
