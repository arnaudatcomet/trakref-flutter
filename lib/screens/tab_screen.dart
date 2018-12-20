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
            length: 4,
            child: new Scaffold(
              bottomNavigationBar:  TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    new Tab(
                        icon: new Icon(Icons.home)
                    ),
                    new Tab(
                        icon: new Icon(Icons.search)
                    ),
                    new Tab(
                        icon: new Icon(Icons.add_box)
                    ),
                    new Tab(
                        icon: new Icon(Icons.settings)
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
                ),
                new Container(
                    color: Colors.green
                )
              ]
              ),
            )
        )
    );
  }
}
