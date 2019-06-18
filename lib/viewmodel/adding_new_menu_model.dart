
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class AddingNewMenuModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  WorkOrder _currentOrder;
  WorkOrder get currentOrder => _currentOrder;

  fetchCurrentWorkOrder() async {
    setState(ViewState.Busy);
    _currentOrder = await _api.getCurrentWorkOrder();
    setState(ViewState.Idle);
  }

  setCurrentWorkOrder(WorkOrder order) async {
    setState(ViewState.Busy);
    _api.setWorkOrder(order);
    _currentOrder = order;
    setState(ViewState.Idle);
  }
}
