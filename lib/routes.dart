import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/bloc/login_bloc.dart';
import 'package:trakref_app/screens/page_login_bloc.dart';
import 'package:trakref_app/screens/tab_screen.dart';

final routes = {
  '/login': (BuildContext context) => BlocProvider(bloc: LoginBloc(), child: PageLoginBloc()),
  '/': (BuildContext context) => BlocProvider(bloc: LoginBloc(), child: PageLoginBloc()),
  '/home': (BuildContext context) => TabScreens()
};