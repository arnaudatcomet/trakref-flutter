import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/screens/adding/page_adding_bloc.dart';
import 'package:trakref_app/screens/search/page_search_bloc.dart';
import 'package:trakref_app/screens/home/page_dashboard_bloc.dart';
import 'package:trakref_app/screens/settings/page_settings_bloc.dart';
import 'package:trakref_app/viewmodel/dropdown_model.dart';

class TabScreens extends StatefulWidget {
  @override
  _TabScreensState createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // We will load the dropdown
    return BaseView<DropdownsModel>(
      onModelReady: (model) => model.getDropdowns(),
      builder: (context, model, child) {
        return (model.state == ViewState.Busy)
            ? Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()))
            : DefaultTabController(
                length: 4,
                child: new Scaffold(
                  bottomNavigationBar: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        new Tab(
                            icon: Image.asset('assets/images/icon-home.png',
                                height: 24)),
                        new Tab(
                            icon: Image.asset('assets/images/icon-search.png',
                                height: 24)),
                        new Tab(
                            icon: Image.asset('assets/images/icon-add.png',
                                height: 24)),
                        new Tab(
                            icon: Image.asset('assets/images/icon-settings.png',
                                height: 24))
                      ]),
                  body: TabBarView(children: [
                    PageDashboardBloc(),
                    PageSearchBloc(),
                    PageAddingBloc(),
                    PageSettingsBloc()
                  ]),
                ));
      },
    );
  }
}
