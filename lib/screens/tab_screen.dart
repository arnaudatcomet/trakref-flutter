import 'package:flutter/material.dart';
import 'package:trakref_app/screens/page_accounts_bloc.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/screens/page_search_bloc.dart';
import 'package:trakref_app/screens/page_settings_screen.dart';

class TabScreens extends StatefulWidget {
  @override
  _TabScreensState createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                PageDashboardBloc(),
                PageSearchBloc(),
                PageAccountsBloc(),
                PageSettingsScreens()
              ]
              ),
            )
        );
  }
}
