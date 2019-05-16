import 'package:flutter/material.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

class ServiceEventResultWidget extends StatelessWidget {
  final List<WorkOrder> orders;
  Function serviceEventSelectedHandle;
  ServiceEventResultWidget({this.orders, this.serviceEventSelectedHandle});

  @override
  Widget build(BuildContext context) {
    return (orders == null) ? Container() : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          WorkOrder order = orders[index];
//          print("order #$index orderNumber : ${order.workOrderNumber} location : ${order.location} instance : ${order.instance}");
          return GestureDetector(
            onTap: () {
              serviceEventSelectedHandle(order);
            },
            child: ServiceEventCellWidget(
              order: order,
            ),
          );
        }
    );
  }
}
