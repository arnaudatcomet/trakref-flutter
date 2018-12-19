import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/bloc/login_bloc.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/logged_user_entity.dart';

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

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    TextEditingController passwordController = new TextEditingController();
    TextEditingController usernameController = new TextEditingController();

    return Scaffold(
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Center(
            child: new Form(
              key: _formKey,
                child: new ListView(
                  children: <Widget>[
                    new Container(
                      child: new Image.asset("assets/images/logo.png",
                          height: 50,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fitHeight),
                      margin: new EdgeInsets.only(top: 103, bottom: 30),
                    ),
                    new Container(
                      child: new Text("Welcome back.", style: TextStyle().copyWith(
                          color: AppColors.gray,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SFProTextRegular"
                      )
                      ),
                    ),
                    new Container(
                        margin: new EdgeInsets.only(top: 30, bottom: 30),
                        child: new TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an username';
                            }
                          },
                          onSaved: (String value) {
                            this._data.username = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                              hintText: 'Enter your email adress',
                              labelText: 'Username'
                          ),
                        )
                    ),
                    new TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a password';
                        }
                      },
                      onSaved: (String value) {
                        this._data.password = value;
                      },
                      obscureText: true,
                      textAlign: TextAlign.start,
                      decoration: new InputDecoration(
                          labelText: 'Password',
                          contentPadding: new EdgeInsets.all(0),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: const Icon(Icons.remove_red_eye),
                          )
                      ),
                    ),
                    new Container(
                        margin: EdgeInsets.only(top: 30),
                        child: ButtonTheme(
                          height: 52.0,
                          child: new RaisedButton(
                            color: AppColors.blueTurquoise,
                            child: new Text("Login", style: TextStyle(color: Colors.white, fontSize: 16)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                print('password : ${_data.password}');
                                print('username : ${_data.username}');

                                String username = _data.username;
                                String password = _data.password;

                                LoggedUser attemptedUser = LoggedUser.empty();
                                attemptedUser.username = username;
                                attemptedUser.password = password;

//                                loginBloc.setUsernameLogin.add(username);
//                                loginBloc.setPasswordLogin.add(password);
                                loginBloc.submitLogin.add(attemptedUser);
                              }
                            },
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4),
                            ),
                          ),
                        )
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: new InkWell(
                          onTap: () => print("Forgot password"),
                          child: new Text("Forgot Password ?",
                              style: TextStyle(color: AppColors.gray)
                          )
                      ),
                    )
                  ],
                )
            ),
          )
      )
    );
  }
}
