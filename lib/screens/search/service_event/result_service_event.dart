import 'package:flutter/material.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

class ServiceEventResultWidget extends StatelessWidget {
  final List<WorkOrder> orders;
  ServiceEventResultWidget({this.orders});

  @override
  Widget build(BuildContext context) {
    return (orders == null) ? Container() : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          WorkOrder order = orders[index];
          if (order.workOrderStatusID == 1) {
            return HomeCellWidget(
                line1: '${order.workOrderNumber}',
                line2: '${order.location}',
                line3: '${order.instance}',
                line4: 'TO DO',
                cellType: HomeCellType.StickerTODO
            );
          }
          else if (order.workOrderStatusID == 2) {
            return HomeCellWidget(
                line1: '${order.workOrderNumber}',
                line2: '${order.location}',
                line3: '${order.instance}',
                line4: 'COMPLETE',
                cellType: HomeCellType.StickerCOMPLETE
            );
          }
          return Container();
        }
    );
  }
}
