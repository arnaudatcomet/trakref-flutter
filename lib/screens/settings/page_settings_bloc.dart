import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/screens/accounts/page_accounts_bloc.dart';
import 'package:trakref_app/screens/settings/support/page_topics_bloc.dart';
import 'package:trakref_app/screens/settings/account_detail/page_account_detail_bloc.dart';
import 'package:trakref_app/screens/settings/profile_detail/page_profile_detail_bloc.dart';


class PageSettingsBloc extends StatefulWidget {
  @override
  _PageSettingsBlocState createState() => _PageSettingsBlocState();
}

class _PageSettingsBlocState extends State<PageSettingsBloc> {
  static const platform = const MethodChannel('flutter.native/zendesk');

  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('showZDChat');
      response = result;
      print("result of 'showZDChat'");
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      print("$response");
    }
  }

  // List items
  Widget buildItem(String title, bool isPushing, Function onTapped) {
    return GestureDetector(
      onTap: onTapped,
      child: Row(
        children: <Widget>[
          SizedBox(height: 50),
          Text(title,
            style: Theme.of(context).textTheme.headline,
          ),
          Spacer(),
          (isPushing) ? Icon(Icons.chevron_right) : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Settings",
                      style: Theme
                          .of(context)
                          .textTheme
                          .title,
                      textAlign: TextAlign.start,
                    )
                  ],
                )
                ,
                SizedBox(height: 20),
                buildItem("Account Details", true, () {
                  TrakrefAPIService().getSelectedAccount().then((selectedAccount){
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (BuildContext context) {
                          return PageAccountDetailBloc(
                            account: selectedAccount
                          );
                        }));
                  });
                }),
                Divider(),
                buildItem("My Profile", true, (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return PageProfileDetailBloc(

                      );
                    })
                  );
                }),
                Divider(),
                buildItem("Support", true, () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return PageTopicsBloc(

                        );
                      })
                  );
                }),
                Divider(),
                buildItem("Log Out", false, () {
                  // Properly logout of the service
                  TrakrefAPIService().logout();
                  Navigator.popUntil(context, ModalRoute.withName("/"));
                }),
                Divider(),
              ],
            ),
          )),
    );
  }
}