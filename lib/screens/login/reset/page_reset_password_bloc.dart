import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

class PageResetPasswordBloc extends StatefulWidget {
  @override
  _PageResetPasswordBlocState createState() => _PageResetPasswordBlocState();
}

class _PageResetPasswordBlocState extends State<PageResetPasswordBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: AppColors.gray),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.0),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.title,
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text(
                        "We will send you an email to reset your password.",
                        style: Theme.of(context).textTheme.body1,
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an email';
                          }
                        },
                        onSaved: (String value) {
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                            hintText: 'Enter your email adress',
                            labelText: 'Email'
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: ButtonTheme(
                    height: 52.0,
                    child: new RaisedButton(
                      key: Key('SubmitButton'),
                      color: AppColors.blueTurquoise,
                      child: Text("RESET PASSWORD", style: TextStyle(color: Colors.white, fontSize: 16)
                      ),
                      onPressed: () {
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4),
                      ),
                    ),
                  )
              )
            ],
          )),
        )
    );
  }
}
