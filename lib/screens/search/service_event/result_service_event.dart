import 'package:flutter/material.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

class ServiceEventResultWidget extends StatefulWidget {
  final List<WorkOrder> orders;
  Function serviceEventSelectedHandle;
  ServiceEventResultWidget({this.orders, this.serviceEventSelectedHandle});

  @override
  _ServiceEventResultWidgetState createState() =>
      _ServiceEventResultWidgetState();
}

class _ServiceEventResultWidgetState extends State<ServiceEventResultWidget>
    with AutomaticKeepAliveClientMixin<ServiceEventResultWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return (widget.orders == null)
        ? Container()
        : ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) {
              WorkOrder order = widget.orders[index];
              return GestureDetector(
                onTap: () {
                  widget.serviceEventSelectedHandle(order);
                },
                child: ServiceEventCellWidget(
                  order: order,
                ),
              );
            });
  }
}