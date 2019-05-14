import 'package:flutter/material.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/screens/details/page_work_order_detail_bloc.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';
import 'package:trakref_app/widget/service_event_widget.dart';

class DashboardTitleTile extends StatelessWidget {
  String title;
  Function onReload;

  DashboardTitleTile({this.title, this.onReload});

  final double paddingTop = 34;
  final double paddingBottom = 20;

  @override
  Widget build(BuildContext context) {
    return (onReload == null)
        ? Column(
            children: <Widget>[
              SizedBox(
                height: paddingTop
              ),
              ListTile(
                  title: Text(
                title ?? "",
                style: Theme.of(context).textTheme.title,
              )),
              SizedBox(
                  height: paddingBottom
              ),
              Divider(
                height: 2,
              )
            ],
          )
        : Column(
            children: <Widget>[
              SizedBox(
                  height: paddingTop
              ),
              ListTile(
                  trailing: IconButton(
                      icon: const Icon(Icons.refresh), onPressed: onReload),
                  title: Text(
                    title ?? "",
                    style: Theme.of(context).textTheme.title,
                  )),
              SizedBox(
                  height: paddingBottom
              ),
              Divider(
                height: 2,
              )
            ],
          );
  }
//
}

class PageDashboardBloc extends StatefulWidget {
  @override
  _PageDashboardBlocState createState() => _PageDashboardBlocState();
}

class _PageDashboardBlocState extends State<PageDashboardBloc> {
  bool _isServiceEventsLoaded = false;
  List<WorkOrder> _serviceEventsResult;
  TrakrefAPIService api = TrakrefAPIService();

  @override
  void dispose() {
    api.close();
    super.dispose();
  }

  @override
  void initState() {
//    int locationID = 47658;
//    getServiceEvents(locationID);

    api.getServiceEvents([]).then((results) {
      _isServiceEventsLoaded = true;
      setState(() {
        _serviceEventsResult = results;
      });
    });

    super.initState();
  }

  // Renderer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: (_isServiceEventsLoaded == false)
            ? FormBuild.buildLoader()
            : ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                itemCount: _serviceEventsResult.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return DashboardTitleTile(title: 'Assigned to you');
                  } else if (index < (_serviceEventsResult.length + 1)) {
                    final item = _serviceEventsResult[index - 1];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (builderContext){
                          return PageWorkOrderDetailBloc(
                              order: item
                          );
                        }));
                      },
                      child: ServiceEventCellWidget(
                        order: item,
                      ),
                    );
                  } else {
                    return DashboardTitleTile(
                        title: 'To Synchronize',
                        onReload: () {
                          // Do something
                        });
                  }
                }));
  }
}
