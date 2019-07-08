import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class WorkOrdersModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  List<WorkOrder> _orders;
  List<WorkOrder> get orders => _orders;

  List<WorkOrder> _filteredOrders;
  List<WorkOrder> get filteredOrders => _filteredOrders;

  bool _showOpened;
  TextEditingController controller;

  fetchWorkOrders() async {
    setState(ViewState.Busy);
    _orders = await _api.getServiceEvents([]);

    // Sort the work orders
    _orders.sort((event1, event2) {
      return (event1.location ?? "").compareTo(event2.location ?? "");
    });

    _filteredOrders = _orders;

    setState(ViewState.Idle);
  }

  fetchBasedOnStatus(bool onlyOpened) {
    setState(ViewState.Busy);
    _filteredOrders = (onlyOpened)
        ? _orders.where((i) => i.workOrderStatusID == 1).toList() : _orders;
    _filteredOrders.sort((event1, event2) {
      return (event1.location ?? "").compareTo(event2.location ?? "");
    });
    setState(ViewState.Idle);
  }

  List<WorkOrder> fetchFromSearch(String searchedText) {
    if (_orders == null) return [];

    List<WorkOrder> _filteredServiceEventsResult = [];
    String searchingFor = searchedText.toLowerCase();
    _orders.forEach((workOrder) {
      if (workOrder.workOrderNumber.toLowerCase().contains(searchingFor) ||
          workOrder.location.toLowerCase().contains(searchingFor) ||
          workOrder.instance.toLowerCase().contains(searchingFor)) {
        _filteredServiceEventsResult.add(workOrder);
      }
    });

    return _filteredServiceEventsResult;
  }
}
