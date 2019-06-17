import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/bloc/dashboard_bloc.dart';
import 'package:trakref_app/bloc/search_bloc.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/screens/accounts/page_accounts_bloc.dart';
import 'package:trakref_app/screens/page_asset_add_bloc.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/screens/login/page_login_bloc.dart';
import 'package:trakref_app/screens/page_main.dart';
import 'package:trakref_app/screens/search/page_search_bloc.dart';
import 'package:trakref_app/screens/adding/service_event/page_service_event_add_bloc.dart';
import 'package:trakref_app/screens/settings/support/page_topics_bloc.dart';
import 'package:trakref_app/screens/settings/page_settings_bloc.dart';
import 'package:trakref_app/screens/tab_screen.dart';

final routes = {
  '/': (BuildContext context) => PageLoginBloc(),
//  '/': (BuildContext context) => PageMain(),
//  '/': (BuildContext context) => TabScreens(),
  '/dashboard': (BuildContext context) => BlocProvider(bloc: DashboardBloc(), child: PageDashboardBloc()),
  '/home': (BuildContext context) => TabScreens(),
  '/search': (BuildContext context) => BlocProvider(bloc: SearchBloc(), child: PageSearchBloc()),
//  '/topics': (BuildContext context) => PageTopicsBloc(),
  '/accounts': (BuildContext context) => PageAccountsBloc(),
  '/assets': (BuildContext context) => PageAssetAddBloc(),
  '/leaks': (BuildContext context) => PageServiceEventAddBloc(),
  '/settings': (BuildContext context) => PageSettingsBloc()
};