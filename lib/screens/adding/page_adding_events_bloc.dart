import 'package:flutter/material.dart';


class PageAddingEventsBloc extends StatefulWidget {
  @override
  _PageAddingEventsBloc createState() => _PageAddingEventsBloc();
}

class _PageAddingEventsBloc extends State<PageAddingEventsBloc> {
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
                    Text("Add new",
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
                buildItem("Service Event", true, null),
                Divider(),
                buildItem("Cylinder", true, null),
                Divider(),
                buildItem("Appliance", true, null),
                Divider(),
                buildItem("Work Order", true, null),
                Divider(),
              ],
            ),
          )),
    );
  }
}
