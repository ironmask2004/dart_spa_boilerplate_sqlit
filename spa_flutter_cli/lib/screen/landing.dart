import 'package:spa_flutter_cli/exp_library.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  // String _userId = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    User.id = await MySharedPreferences.instance.getStringValue('userId');

    print('================= get USER ID============= ' + User.id.toString());

    final String? _userId = User.id;
    //print('Landing UserID:' + _userId!);
    if (_userId == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } else {
      ApiResponse _apiResponse = await getUserDetails(_userId!);
      print("=====================" +
          (_apiResponse.ApiError as ApiError).toJson()['error']);
      print('response data ' + _apiResponse.Data.toString());
      if ((_apiResponse.ApiError as ApiError).toJson()['error'] == "200") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'),
            arguments: (_apiResponse.Data as User));
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
