import 'package:flutter/material.dart';

class TabScreens extends StatefulWidget {
  @override
  _TabScreensState createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  @override
  Widget build(BuildContext context) {
    return  new MaterialApp(
        color: Colors.yellow,
        home: DefaultTabController(
            length: 3,
            child: new Scaffold(
              bottomNavigationBar:  TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    new Tab(
                        icon: new Icon(Icons.home)
                    ),
                    new Tab(
                        icon: new Icon(Icons.rss_feed)
                    ),
                    new Tab(
                        icon: new Icon(Icons.assessment)
                    )
                  ]
              ),
              body: TabBarView(children:
              [
                new Container(
                    color: Colors.yellow
                ),
                new Container(
                    color: Colors.blue
                ),
                new Container(
                    color: Colors.red
                )
              ]
              ),
            )
        )
    );
  }
}
