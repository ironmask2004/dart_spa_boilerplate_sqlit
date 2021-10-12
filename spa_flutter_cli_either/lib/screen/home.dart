import 'package:spa_flutter_cli_either/exp_library.dart';
import 'package:dartz/dartz.dart' as dartz;

class MyHomePage extends StatefulWidget {
  // MyHomePage({  required this.title}) : super(key: key);
  final String title = "ewrwerw";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _handleLogout() async {
    print('logout ' + User.id!);
    final dartz.Either<ApiResponse, String> userInfo =
        await logOutUser(User.id!);

    userInfo.fold((left) {
      showInSnackBar(context, (left.ApiError as ApiError).error);
    }, (right) async {
      showInSnackBar(context, ("LogOut Successs!!"));

      await MySharedPreferences.instance.removeValue('userId');

      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    });
  }

  @override
  Widget build(BuildContext context) {
    //final Object? args = ModalRoute.of(context)?.settings.arguments;
    //print(args.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text(User.email!),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Welcome back " + User.email! + "!"),
              const Text('Last login was on  args.lastLogin'),
              //Text("Your Email is  " + args.email),
              ElevatedButton(
                onPressed: _handleLogout,
                child: const Text("Logout"),
              )
            ],
          ),
        ));
  }
}
