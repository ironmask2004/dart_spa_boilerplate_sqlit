import 'package:spa_flutter_cli/exp_library.dart';


class MyHomePage extends StatefulWidget {
 // MyHomePage({  required this.title}) : super(key: key);
  final String title ="ewrwerw";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logOutUser(User.id!);
    prefs.remove('userId');

    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             // Text("Welcome back " + args?.name + "!"),
              //Text("Last login was on " + args.lastLogin),
              //Text("Your Email is  " + args.email),
              ElevatedButton(
                onPressed: _handleLogout,
                child: Text("Logout"),
              )
            ],
          ),
        ));
  }
}