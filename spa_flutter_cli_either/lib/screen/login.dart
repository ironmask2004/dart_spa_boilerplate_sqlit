import 'package:spa_flutter_cli_either/exp_library.dart';
import 'package:dartz/dartz.dart' as dartz;

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          key: Key("_email"),
                          decoration: const InputDecoration(labelText: "email"),
                          keyboardType: TextInputType.text,
                          initialValue: 'melocalcom1',
                          onSaved: (value) {
                            _email = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email is required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Password"),
                          obscureText: true,
                          initialValue: '123456',
                          onSaved: (value) {
                            _password = value!;
                            print('saved password:' + _password);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        ButtonBar(
                          children: <Widget>[
                            ElevatedButton.icon(
                                onPressed: () {
                                  print("email + password was :" +
                                      _email +
                                      _password);
                                  _handleSubmitted(context);
                                },
                                icon: Icon(Icons.arrow_forward),
                                label: Text('Sign in')),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }

  void _handleSubmitted(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // int counter = (prefs.getInt('counter') ?? 0) +  1;
    // await prefs.setInt('counter', counter);
    // print(
    //    '=======================================================  Pressed $counter times.');

    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
      showInSnackBar(
          context, 'Please fix the errors in red before submitting.');
    } else {
      form.save();

      print(" calling func email + password was :" + _email + _password);

      try {
        final dartz.Either<ApiResponse, User> userInfo =
            await loginUser(_email, _password);

        userInfo.fold((left) {
          showInSnackBar(context, (left.ApiError as ApiError).error);
        }, (right) {
          showInSnackBar(context, ("Login Successs!!"));

          print('------------------------------------');
          _saveAndRedirectToHome(context, right);
        });
      } catch (err) {
        print('Error connectiing to server ' + err.toString());

        showInSnackBar(context, err.toString());
      }
    }
  }

  void _saveAndRedirectToHome(BuildContext context, User userIfo) async {
    print('>> _saveAndRedirectToHome: userToken:' +
        User.token! +
        '\\n refreshToken: ' +
        User.refreshToken!);

    //final String? _usertoken = User.token;

    await MySharedPreferences.instance.setStringValue('token', User.token!);
    await MySharedPreferences.instance
        .setStringValue('refreshToken', User.refreshToken!);

    print('User.token : ========== ' +
        await MySharedPreferences.instance.getStringValue('token'));

    print('User.refreshToken : ========== ' +
        await MySharedPreferences.instance.getStringValue('refreshToken'));

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (userIfo));
  }
}
