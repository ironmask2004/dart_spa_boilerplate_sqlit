import 'package:spa_flutter_cli_either/exp_library.dart';

class ApiError {
  late String _error;
  late String _errorNo;

  String get errorNo => this._errorNo;
  set errorNo(String errorNo) => this._errorNo = errorNo;

  ApiError({required String error, required String errorNo}) {
    this._error = error;
    this._errorNo = errorNo;
  }

  String get error => _error;
  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
    _errorNo = json['errorNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this._error;
    data['errorNo'] = this._errorNo;
    return data;
  }
}
