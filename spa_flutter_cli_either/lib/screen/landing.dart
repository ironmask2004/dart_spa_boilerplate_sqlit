import 'package:spa_flutter_cli_either/exp_library.dart';
import 'package:dartz/dartz.dart' as dartz;

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _userToken = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    try {
      print('UUUUUUUUUU---------------------');
      User.token = await MySharedPreferences.instance.getStringValue('token');
      User.refreshToken =
          await MySharedPreferences.instance.getStringValue('refreshToken');
      print('User.token : ========== ' + User.token!);
      _userToken = User.token!;
    } catch (err) {
      print('Err Getting saved user id');
    }

    if (_userToken == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      print('Get User inffffffffffffffffffff000');
      print('000000000000000000000000');

      try {
        print('1111111111111111111111111');
        final dartz.Either<ApiResponse, User> _userInfo =
            await getUserInfo(_userToken);
        print('2222222222222222222222222');

        _userInfo.fold((left) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', ModalRoute.withName('/login'));
          showInSnackBar(context, (left.ApiError as ApiError).error);
        }, (right) {
          print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
          User.token = _userToken;
          print("goooooo HOOOOOOOOOOOOOOOme ");
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', ModalRoute.withName('/home'),
              arguments: (right));
          showInSnackBar(context, ("Login Successs!!"));

          print('------------------------------------');
        });
      } catch (err) {
        print('Error connectiing to server ' + err.toString());

        showInSnackBar(context, 'Error connectiing to server');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
