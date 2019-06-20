import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/screens/details/page_work_order_detail_bloc.dart';
import 'package:trakref_app/viewmodel/workorders_model.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

class DashboardTitleTile extends StatelessWidget {
  String title;
  Function onReload;

  DashboardTitleTile({this.title, this.onReload});

  final double paddingTop = 34;
  final double paddingBottom = 20;

  @override
  Widget build(BuildContext context) {
    String title = this.title ?? "";
    return (onReload == null)
        ? Column(
            children: <Widget>[
              SizedBox(height: paddingTop),
              ListTile(
                  title: Text(
                title,
                style: Theme.of(context).textTheme.title,
              )),
              SizedBox(height: paddingBottom),
              Divider(
                height: 2,
              )
            ],
          )
        : Column(
            children: <Widget>[
              SizedBox(height: paddingTop),
              ListTile(
                  trailing: IconButton(
                      icon: const Icon(Icons.refresh), onPressed: onReload),
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.title,
                  )),
              SizedBox(height: paddingBottom),
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

class _PageDashboardBlocState extends State<PageDashboardBloc>
    with AutomaticKeepAliveClientMixin<PageDashboardBloc> {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // Renderer
  @override
  Widget build(BuildContext context) {
    return BaseView<WorkOrdersModel>(
      onModelReady: (model) => model.fetchWorkOrders(),
      builder: (context, model, child) {
        List<WorkOrder> _serviceEventsResult = model.orders;
        var ordersAssigned = ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            itemCount: ((_serviceEventsResult != null)
                    ? _serviceEventsResult.length
                    : 0) +
                2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return DashboardTitleTile(title: 'Assigned to you');
              } else if (index < (_serviceEventsResult.length + 1)) {
                final item = _serviceEventsResult[index - 1];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builderContext) {
                      return PageWorkOrderDetailBloc(order: item);
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
            });
        return Scaffold(
            backgroundColor: Colors.white,
            body: (model.state == ViewState.Busy)
                ? FormBuild.buildLoader()
                : RefreshIndicator(
                    color: AppColors.blueTurquoise,
                    child: ordersAssigned,
                    onRefresh: () {
                      model.fetchWorkOrders();
                    },
                  ));
      },
    );
  }
}
