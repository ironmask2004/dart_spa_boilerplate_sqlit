import 'package:spa_flutter_cli/exp_library.dart';

class Login extends StatelessWidget {
  // const Login({Key? key}) : super(key: key);
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
                          onSaved: (value) {
                            _password = value!;
                            print('saved password:' +_password  );
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
                                  print("email + password was :" + _email + _password);
                                   _handleSubmitted(context );
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
    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
      showInSnackBar(
          context, 'Please fix the errors in red before submitting.');
    } else {
      form.save();
      print(" callinf fun email + password was :" + _email + _password);
      var _apiResponse = await authenticateUser(_email, _password);
      if ((_apiResponse.ApiError as ApiError) == null) {
        _saveAndRedirectToHome(context, _apiResponse);
      } else {
        showInSnackBar(context, (_apiResponse.ApiError as ApiError).error);
      }
    }
  }

  void _saveAndRedirectToHome(
      BuildContext context, ApiResponse _apiResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? _userId = (_apiResponse.Data as User).id;
    await prefs.setString("userId", _userId!);
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/home'),
        arguments: (_apiResponse.Data as User));
  }

  void showInSnackBar(BuildContext context, String error) {
    final snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
