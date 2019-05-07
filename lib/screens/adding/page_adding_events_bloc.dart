import 'package:flutter/material.dart';
import 'package:trakref_app/screens/adding/service_event/page_service_event_add_bloc.dart';


class PageAddingEventsBloc extends StatefulWidget {
  @override
  _PageAddingEventsBloc createState() => _PageAddingEventsBloc();
}

class _PageAddingEventsBloc extends State<PageAddingEventsBloc> {
  Widget buildItem(String title, bool isPushing, Function onTapped) {
    return GestureDetector(
      onTap: onTapped,
      child: Row(
        children: <Widget>[
          SizedBox(height: 50),
          Text(title,
            style: Theme.of(context).textTheme.headline.copyWith(
              color: (isPushing) ? Colors.black : Colors.black38
            )
          ),
          Spacer(),
          (isPushing) ? Icon(Icons.chevron_right) : Container()
        ],
      )
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
                buildItem("Service Event", true, () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
                    return PageServiceEventAddBloc(
                    );
                  }));
                }),
                Divider(),
                buildItem("Cylinder", false, null),
                Divider(),
                buildItem("Appliance", false, null),
                Divider(),
                buildItem("Work Order", false, null),
                Divider(),
              ],
            ),
          )),
    );
  }
}
