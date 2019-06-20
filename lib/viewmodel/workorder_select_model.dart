import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class WorkOrderSelectModel extends BaseModel {
  CachingAPIService _cachedApi = CachingAPIService();
  List<WorkOrder> orders;
  TextEditingController controller;

  refreshWorkOrders() async {
    _cachedApi.clearServiceEvents();
    fetchWorkOrders();
  }

  fetchWorkOrders() async {
    setState(ViewState.Busy);
    if (_cachedApi.cachedServiceEvents == null) {
      orders = await _cachedApi.fetchCachedServiceEvents();
    } else {
      orders = _cachedApi.cachedServiceEvents;
    }

    // Sort the work orders
    orders.sort((event1, event2) {
      return (event1.location ?? "").compareTo(event2.location ?? "");
    });

    setState(ViewState.Idle);
  }

  List<WorkOrder> fetchWorkOrdersFromSearch(String searching) {
    return fetchFromSearch(orders, searching);
  }

  List<WorkOrder> fetchFromSearch(List<WorkOrder> items, String searching) {
    if (items == null) return [];

    return items.where((workOrder) => (workOrder.workOrderNumber.toLowerCase().contains(searching) ||
            workOrder.location.toLowerCase().contains(searching) ||
            workOrder.instance.toLowerCase().contains(searching))).toList();
  }
}
