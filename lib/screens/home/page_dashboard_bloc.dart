import 'package:flutter/material.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';
import 'package:trakref_app/widget/service_event_widget.dart';

class DashboardTitleTile extends StatelessWidget {
  String title;
  DashboardTitleTile({this.title});
  Function onReload;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        title: Text(
          title ?? "",
          style: Theme.of(context).textTheme.title,
        ),
        trailing: IconButton(icon: const Icon(Icons.refresh), onPressed: onReload)
    );;
  }
}

class PageDashboardBloc extends StatefulWidget {
  @override
  _PageDashboardBlocState createState() => _PageDashboardBlocState();
}

class _PageDashboardBlocState extends State<PageDashboardBloc> {
  bool _isServiceEventsLoaded = false;
  List<WorkOrder> _serviceEventsResult;
  ApiService api = ApiService();

  getServiceEvents(int locationID) {
    // Below for showing the GET Work Orders
    var baseUrl = "$baseURL/WorkOrders?locationID=$locationID";
    api.getResult<WorkOrder>(baseUrl).then((results) {
      _isServiceEventsLoaded = true;
      setState(() {
        _serviceEventsResult = results;
      });
    });
  }

  @override
  void dispose() {
    api.close();
    super.dispose();
  }

  @override
  void initState() {
    int locationID = 47658;
    getServiceEvents(locationID);
    super.initState();
  }

  // Renderer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_isServiceEventsLoaded == false) ? FormBuild.buildLoader() : ListView.builder(
    itemCount: _serviceEventsResult.length + 1,
        itemBuilder: (context, index) {
          if (index == 0 ) {
            return DashboardTitleTile(title: 'Assigned to you');
          }
          final item = _serviceEventsResult[index-1];
          return ServiceEventCellWidget(
            order: item,
          );
        }
    )
    );
  }
}
