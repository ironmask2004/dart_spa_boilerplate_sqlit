import 'package:spa_flutter_cli/exp_library.dart';
import 'package:dartz/dartz.dart' as dartz;

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _userId = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    try {
      User.id = await MySharedPreferences.instance.getStringValue('userId');
      _userId = User.id!;
    } catch (err) {
      print('Err Getting saved user id');
    }

    if (_userId == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      final dartz.Either<ApiResponse, User> _userInfo =
          await getUserInfo(_userId);
      if (_userInfo.isRight()) {
        User.id = _userId;
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'),
            arguments: (_userInfo));
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
