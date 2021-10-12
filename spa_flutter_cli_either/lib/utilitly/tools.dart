import 'package:spa_flutter_cli_either/exp_library.dart';

void showInSnackBar(BuildContext context, String error) {
  final snackBar = SnackBar(content: Text(error));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
