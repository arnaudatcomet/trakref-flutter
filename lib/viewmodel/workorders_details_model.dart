import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

enum WorkOrderActivityOptions {
  LeakInspection,
  ServiceAndLeakRepair,
  Shutdown
}

class WorkOrdersDetailModel extends BaseModel {
  WorkOrder _currentWorkOrder;
  WorkOrder get currentWorkOrder => _currentWorkOrder;

  WorkOrderActivityOptions _currentOption;
  WorkOrderActivityOptions get currentOption => _currentOption;
  
  List<WorkItem> get serviceEvents => _currentWorkOrder.workItem;

  List<WorkItem> _filteredServiceEvents;
  List<WorkItem> get filteredServiceEvents => _filteredServiceEvents;

  bool _isExpanded = true;
  bool get isExpanded => _isExpanded;

  Function didMaximizeChanged;

  init(WorkOrder order) {
    _currentWorkOrder = order;
    _filteredServiceEvents = serviceEvents;
  }

  toggleExpand() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  set(WorkOrderActivityOptions option) {
    _currentOption = (_currentOption != option) ? option : null;
    sort(_currentOption);
    notifyListeners();
  }

  getCount(WorkOrderActivityOptions option) {
    switch (option) {
      case WorkOrderActivityOptions.LeakInspection:
        return serviceEvents.where((i) => (i.workItemTypeID == 2)).toList().length;
        break;
      case WorkOrderActivityOptions.ServiceAndLeakRepair:
        return serviceEvents.where((i) => (i.workItemTypeID == 3)).toList().length;
        break;
      case WorkOrderActivityOptions.Shutdown:
        return serviceEvents.where((i) => (i.workItemTypeID == 5)).toList().length;
        break;
    }
    return 0;
  }
  sort(WorkOrderActivityOptions option) {
    setState(ViewState.Busy);
    switch (option) {
      case WorkOrderActivityOptions.LeakInspection:
        _filteredServiceEvents = serviceEvents.where((i) => (i.workItemTypeID == 2)).toList();
        break;
      case WorkOrderActivityOptions.ServiceAndLeakRepair:
        _filteredServiceEvents = serviceEvents.where((i) => (i.workItemTypeID == 3)).toList();
        break;
      case WorkOrderActivityOptions.Shutdown:
        _filteredServiceEvents = serviceEvents.where((i) => (i.workItemTypeID == 5)).toList();
        break;
      default:
        _filteredServiceEvents = serviceEvents;
    }
    setState(ViewState.Idle);
  }
}