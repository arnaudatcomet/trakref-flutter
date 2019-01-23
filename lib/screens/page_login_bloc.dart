import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/bloc/login_bloc.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/logged_user_entity.dart';
import 'package:trakref_app/widget/loading_widget.dart';

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
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    this.loginBloc = BlocProvider.of<LoginBloc>(context);

    this.loginBloc.nextScreen.listen((LoggedUser user) {
      Navigator.of(context).pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          child: new Text("Welcome back.", style: Theme.of(context).textTheme.title
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
                                key: Key('SubmitButton'),
                                color: AppColors.blueTurquoise,
                                child: StreamBuilder(
                                    initialData: LoggedUser.empty(),
                                    stream: this.loginBloc.resultLogin,
                                    builder: (BuildContext context, AsyncSnapshot<LoggedUser> snapshot) {
                                      print("Loading > ${snapshot.data.toString()}");

                                      return (snapshot.connectionState != ConnectionState.waiting) ? Center(
                                        child: CircularProgressIndicator(strokeWidth: 1
                                        ),
                                      ) : Text("Login", style: TextStyle(color: Colors.white, fontSize: 16));
                                    }
                                ),
                                onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  String username = _data.username;
                                  String password = _data.password;

                                  LoggedUser attemptedUser = LoggedUser.empty();
                                  attemptedUser.username = username;
                                  attemptedUser.password = password;

                                  this.loginBloc.submitLogin.add(attemptedUser);
                                }
                                },
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4),
                                ),
                              ),
                            )
                        ),
                        new StreamBuilder(
                            initialData: LoggedUser.empty(),
                            stream: this.loginBloc.resultLogin,
                            builder: (BuildContext context, AsyncSnapshot<LoggedUser> snapshot) {
                              print("data > ${snapshot.data.toString()}");
                              if (snapshot.hasError) {
                                return new Text("${snapshot.error.toString()}", style: TextStyle(color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic));
                              }

                              return Text("");
                            }
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
