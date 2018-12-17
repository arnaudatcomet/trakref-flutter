import 'dart:async';
import 'package:trakref_app/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Center(
          child:  new Form(
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                        hintText: 'Enter your email adress',
                        labelText: 'Username'
                    ),
                  )
                ),
                  new TextFormField(
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
                        onPressed: (() => print("Hello")),
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
      ),
    );
  }
}
