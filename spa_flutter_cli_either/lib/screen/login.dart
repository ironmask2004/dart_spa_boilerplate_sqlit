import 'package:spa_flutter_cli/exp_library.dart';

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
      var _apiResponse = await authenticateUser(_email, _password);
      print('handle_submtted---  ' +
          (_apiResponse.ApiError as ApiError).toJson()['error']);
      if ((_apiResponse.ApiError as ApiError).toJson()['error'] == "200") {
        _saveAndRedirectToHome(context, _apiResponse);
      } else {
        showInSnackBar(context, (_apiResponse.ApiError as ApiError).error);
      }
    }
  }

  void _saveAndRedirectToHome(
      BuildContext context, ApiResponse _apiResponse) async {
    print('>> _saveAndRedirectToHome: UserId:' +
        User.id!); // User.id = _apiResponse.Data.id;

    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? _userId = User.id;
//    await prefs.setString("userId", _userId!);
    await MySharedPreferences.instance.setStringValue('userId', _userId!);

    print("saved User_Id===============------------============" + _userId);

    /* var _userId2 = (prefs.getString('userId') ?? "");
    print ('reaeding shared prefrances UserID:' + _userId2 );
*/
    //  prefs.commit();

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (_apiResponse.Data as User));
  }

  void showInSnackBar(BuildContext context, String error) {
    final snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
