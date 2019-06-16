import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class WorkOrdersModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  List<WorkOrder> orders;
  TextEditingController controller;

  Future fetchWorkOrders() async {
    setState(ViewState.Busy);
    orders = await _api.getServiceEvents([]);

    // Sort the work orders
    orders.sort((event1, event2) {
      print("Compare '${event1.location}' > '${event2.location}'");
      return (event1.location ?? "").compareTo(event2.location ?? "");
    });

    setState(ViewState.Idle);
  }

  List<WorkOrder> fetchFromSearch(String searchedText) {
    if (orders == null) return [];

    List<WorkOrder> _filteredServiceEventsResult = [];
    orders.forEach((workOrder) {
      if (workOrder.workOrderNumber.toLowerCase().contains(searchedText) ||
          workOrder.location.toLowerCase().contains(searchedText) ||
          workOrder.instance.toLowerCase().contains(searchedText)) {
        _filteredServiceEventsResult.add(workOrder);
      }
    });

    return _filteredServiceEventsResult;
  }
}
