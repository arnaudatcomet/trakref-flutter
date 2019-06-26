import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/viewmodel/workorder_select_model.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

typedef SelectCurrentWorkOrderDelegate = void Function(
    WorkOrder selectedWorkOrder);

class PageSelectCurrentWorkOrderBloc extends StatefulWidget {
  final WorkOrder selectedWorkOrder;
  final SelectCurrentWorkOrderDelegate delegate;
  PageSelectCurrentWorkOrderBloc({this.selectedWorkOrder, this.delegate});

  @override
  _PageSelectCurrentWorkOrderBlocState createState() =>
      _PageSelectCurrentWorkOrderBlocState();
}

class _PageSelectCurrentWorkOrderBlocState
    extends State<PageSelectCurrentWorkOrderBloc> {
  List<WorkOrder> _searchWorkOrdersResult = [];

  bool _searchIsActiveState = false;
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  Widget buildTextfieldRow(String key, String label, String initialValue) {
    if (initialValue == null) {
      return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
        FormBuild.buildTextField(key: Key(key), label: label)
      ]);
    }
    return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
      FormBuild.buildTextField(
          key: Key(key), label: label, initialValue: initialValue)
    ]);
  }

  // Renderer
  @override
  Widget build(BuildContext context) {
    return BaseView<WorkOrderSelectModel>(
      onModelReady: (model) {
        model.fetchWorkOrders().then((results) {
          model.controller = _controller;
          model.controller.addListener(() {
            _searchWorkOrdersResult =
                model.fetchFromSearch(model.orders, _controller.text).toList();
            setState(() {});
          });
        });
      },
      builder: (context, model, child) {
        var workOrderListView = ListView.builder(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            itemCount: (_searchIsActiveState == false)
                ? ((model.orders ?? []).length + 1)
                : (_searchWorkOrdersResult.length),
            itemBuilder: (context, index) {
              if (index == 0 && (_searchIsActiveState == false)) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Select Work Order',
                      style: Theme.of(context).textTheme.title,
                    )
                  ],
                );
              } else {
                final item = (_searchIsActiveState == false)
                    ? model.orders[index-1]
                    : _searchWorkOrdersResult[index-1];
                return InkWell(
                  onTap: () {
                    WorkOrder selectedWorkOrder = (model.orders ?? [])
                        .where((WorkOrder order) => order.id == item.id)
                        .first;
                    widget.delegate(selectedWorkOrder);
                    Navigator.of(context).pop();
                  },
                  child: ServiceEventCellWidget(order: item),
                );
              }
            });

        Widget body = Container();
        if (model.state == ViewState.Busy) {
          body = FormBuild.buildLoader();
        } else if (model.orders.length == 0) {
          body = Container(
            width: double.infinity,
            child:Text("No work order available",
          textAlign: TextAlign.center),
            );
        } else {
          body = RefreshIndicator(
              child: workOrderListView,
              color: AppColors.blueTurquoise,
              onRefresh: () {
                model.refreshWorkOrders();
              });
        }

        return Scaffold(
            appBar: (_searchIsActiveState == true)
                ? AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.clear, color: AppColors.gray),
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  _searchIsActiveState = false;
                                });
                              }),
                          icon: Icon(Icons.search, color: AppColors.gray),
                          hintText: "Search for a work order"),
                    ),
                  )
                : AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: new Icon(Icons.close, color: AppColors.gray),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: <Widget>[
                        IconButton(
                          icon: new Icon(Icons.search, color: AppColors.gray),
                          onPressed: () {
                            setState(() {
                              // Clear the search results
                              _searchWorkOrdersResult = [];
                              _searchIsActiveState = true;
                            });
                          },
                        ),
                      ]),
            backgroundColor: Colors.white,
            body: body);
      },
    );
  }
}
