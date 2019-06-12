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
    setState(ViewState.Idle);
  }
}