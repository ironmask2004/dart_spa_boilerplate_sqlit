import 'package:spa_flutter_cli/exp_library.dart';

class Login extends StatelessWidget {
  // const Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

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
                          key: Key("_username"),
                          decoration: InputDecoration(labelText: "Username"),
                          keyboardType: TextInputType.text,
                       //   onSaved: (String value) {
                      //      _username = value;
                       //   },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Password"),
                          obscureText: true,
                 //         onSaved: (String value) {
                 //           _password = value;
                //          },
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
                            RaisedButton.icon(
                                onPressed: _handleSubmitted,
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
  void _handleSubmitted() async {
    final FormState? form = _formKey.currentState;
    /* if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      _apiResponse = await authenticateUser(_username, _password);
      if ((_apiResponse.ApiError as ApiError) == null) {
        _saveAndRedirectToHome();
      } else {
        showInSnackBar((_apiResponse.ApiError as ApiError).error);
      }
    }
    */
  }


}
