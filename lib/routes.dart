import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/bloc/dashboard_bloc.dart';
import 'package:trakref_app/bloc/login_bloc.dart';
import 'package:trakref_app/bloc/search_bloc.dart';
import 'package:trakref_app/screens/page_accounts_bloc.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/screens/page_login_bloc.dart';
import 'package:trakref_app/screens/page_search_bloc.dart';
import 'package:trakref_app/screens/page_settings_screen.dart';
import 'package:trakref_app/screens/tab_screen.dart';

final routes = {
//  '/': (BuildContext context) => BlocProvider(bloc: LoginBloc(), child: PageLoginBloc()),
  '/': (BuildContext context) => TabScreens(),
//  '/': (BuildContext context) => PageSettingsScreens(),
  '/dashboard': (BuildContext context) => BlocProvider(bloc: DashboardBloc(), child: PageDashboardBloc()),
  '/home': (BuildContext context) => TabScreens(),
  '/search': (BuildContext context) => BlocProvider(bloc: SearchBloc(), child: PageSearchBloc()),
  '/selectAccount': (BuildContext context) => PageAccountsBloc()
};