import 'package:flutter/material.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/screens/settings/account_detail/page_account_detail_bloc.dart';
import 'package:trakref_app/screens/accounts/page_accounts_bloc.dart';
import 'package:trakref_app/screens/adding/page_adding_events_bloc.dart';
import 'package:trakref_app/screens/page_location_bloc.dart';
import 'package:trakref_app/screens/page_profile_bloc.dart';
import 'package:trakref_app/screens/search/page_search_bloc.dart';
import 'package:trakref_app/screens/page_asset_add_bloc.dart';
import 'package:trakref_app/screens/page_settings_screen.dart';
import 'package:trakref_app/screens/page_support_ticket_bloc.dart';
import 'package:trakref_app/screens/page_test_link_bloc.dart';
import 'package:trakref_app/screens/settings/support/page_topics_bloc.dart';
import 'package:trakref_app/screens/home/page_dashboard_bloc.dart';
import 'package:trakref_app/screens/settings/page_settings_bloc.dart';

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
// For testing purposes
//                PageTopicsBloc(),
//                PageAccountsBloc(),
//                PageAssetAddBloc(),
//                PageTestLinkBloc()
//                MyHomePage()
                PageAddingEventsBloc(),
                PageSettingsBloc()
              ]
              ),
            )
        );
  }
}
