import 'package:flutter/material.dart';

class PageSettingsBloc extends StatefulWidget {
  @override
  _PageSettingsBlocState createState() => _PageSettingsBlocState();
}

class _PageSettingsBlocState extends State<PageSettingsBloc> {
  Widget buildItem(String title, bool isPushing, Function onTapped) {
    return Row(
      children: <Widget>[
        SizedBox(height: 50),
        Text(title,
          style: Theme.of(context).textTheme.headline,
        ),
        Spacer(),
        (isPushing) ? Icon(Icons.chevron_right) : Container()
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                buildItem("Account Details", true, null),
                Divider(),
                buildItem("My Profile", true, null),
                Divider(),
                buildItem("Support", true, null),
                Divider(),
                buildItem("Log Out", false, null),
                Divider(),
              ],
            ),
          )),
    );
  }
}
