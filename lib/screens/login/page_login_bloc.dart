import 'package:flutter/material.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/screens/accounts/page_accounts_bloc.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/screens/login/reset/page_reset_password_bloc.dart';
import 'package:trakref_app/viewmodel/login_model.dart';
import 'package:trakref_app/widget/button_widget.dart';

class PageLoginBloc extends StatefulWidget {
  @override
  _PageLoginBlocState createState() => _PageLoginBlocState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _PageLoginBlocState extends State<PageLoginBloc> {
  final _formKey = GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model) => model.clear(),
      builder: (context, model, child) {
        return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            child: Image.asset("assets/images/logo.png",
                                height: 50,
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.fitHeight),
                            margin: const EdgeInsets.only(top: 103, bottom: 30),
                          ),
                          Container(
                            child: Text("Welcome back.",
                                style: Theme.of(context).textTheme.title),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: TextFormField(
                                key: Key(kUsernameKey),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter an username';
                                  }
                                },
                                onSaved: (String value) {
                                  this._data.username = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Enter your username',
                                    labelText: 'Username'),
                              )),
                          TextFormField(
                            key: Key(kPasswordKey),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a password';
                              }
                            },
                            onSaved: (String value) {
                              this._data.password = value;
                            },
                            obscureText: (_showPassword == false),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                contentPadding: const EdgeInsets.all(0),
                                suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    //loginBloc
                                    child: IconButton(
                                        icon: const Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        }))),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 30),
                              child: ButtonTheme(
                                height: 52.0,
                                child: RaisedButton(
                                  key: Key(kSubmitButtonKey),
                                  color: AppColors.blueTurquoise,
                                  child: (model.state == ViewState.Idle)
                                      ? Text("Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))
                                      : CircularProgressIndicator(
                                          key: Key(kLoginProgressCircularKey),
                                          strokeWidth: 1,
                                          backgroundColor: Colors.white),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      String username = _data.username;
                                      String password = _data.password;

                                      bool succeeded =
                                          await model.login(username, password);
                                      if (succeeded != null &&
                                          succeeded == true) {
                                        print("Login was succedeed");

                                        // Fetch the dropdowns
                                        model.fetchDropdowns();

                                        print("Push to a next screen");
                                        _formKey.currentState.reset();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return PageAccountsBloc(
                                              type: PageAccountsType.Home);
                                        }));
                                      } else {
                                        print("Login was failed");
                                      }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )),
                          (model.errorMessage == null)
                              ? Text("", key: Key(kErrorMessageKey))
                              : Text("${model.errorMessage}",
                                  key: Key(kErrorMessageKey),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              LinkAppButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return PageResetPasswordBloc();
                                  }));
                                },
                                title: "Forgot your password?",
                                style: TextStyle(
                                    color: AppColors.gray,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          )
                        ],
                      )),
                )));
      },
    );
  }
}
