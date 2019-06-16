import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class DropdownsModel extends BaseModel {
  TrakrefAPIService _trakrefAPIService = TrakrefAPIService();

  List<DropdownItem> get serviceType => _serviceType;
  List<DropdownItem> _serviceType = [
    DropdownItem(name: 'Leak Inspection', id: 2),
    DropdownItem(name: 'Service and Leak Repair', id: 3),
    DropdownItem(name: 'Shutdown', id: 5)
  ];

  List<DropdownItem> get wasLeakFound => _wasLeakFound;
  List<DropdownItem> _wasLeakFound = [
    DropdownItem(name: 'Yes', id: 1),
    DropdownItem(name: 'No', id: 0)
  ];

  List<DropdownItem> get assetsDropdowns => _assetsDropdowns;
  List<DropdownItem> _assetsDropdowns;

  List<LeakLocationItem> get initialLocationLeakFound => _initialLocationLeakFound;
  List<LeakLocationItem> _initialLocationLeakFound;

  List<LeakLocationItem> get verificationLocationLeakFound => _verificationLocationLeakFound;
  List<LeakLocationItem> _verificationLocationLeakFound;

  List<DropdownItem> get filteredInitialLocationLeakFound => _filteredInitialLocationLeakFound;
  List<DropdownItem> _filteredInitialLocationLeakFound;

  List<DropdownItem> get filteredVerificationLocationLeakFound => _filteredVerificationLocationLeakFound;
  List<DropdownItem> _filteredVerificationLocationLeakFound;

  List<DropdownItem> get categoriesLeakFound => _categoriesLeakFound;
  List<DropdownItem> _categoriesLeakFound;

  List<DropdownItem> get categoryLocationLeakFound => _categoryLocationLeakFound;
  List<DropdownItem> _categoryLocationLeakFound;

  List<DropdownItem> get causeOfLeaks => _causeOfLeaks;
  List<DropdownItem> _causeOfLeaks;

  List<DropdownItem> get leakDetectionMethod => _leakDetectionMethod;
  List<DropdownItem> _leakDetectionMethod;

  List<DropdownItem> get serviceActions => _serviceActions;
  List<DropdownItem> _serviceActions;

  List<DropdownItem> get leakRepairStatus => _leakRepairStatus;
  List<DropdownItem> _leakRepairStatus;

  List<DropdownItem> get serviceTransferReason => _serviceTransferReason;
  List<DropdownItem> _serviceTransferReason;

  List<DropdownItem> get shutdownStatus => _shutdownStatus;
  List<DropdownItem> _shutdownStatus = [
    DropdownItem(name: 'Shutdown', id: 6),
    DropdownItem(name: 'Mothball', id: 2),
    DropdownItem(name: 'Pending Install', id: 12),
  ];

  List<DropdownItem> get depthVacuumAmount => _buildDropdownInt(0, 31);

  // Build Vacuum dept dynamically
  static List<DropdownItem> _buildDropdownInt(int from, int length) {
    List<DropdownItem> intList = List<DropdownItem>();
    for (var i = from; i <= (from + length); i++) {
      intList.add(DropdownItem(name: '$i', id: i));
    }
    return intList;
  }

  Future<bool> getDropdowns() async {
    setState(ViewState.Busy);
    DropdownList results = await _trakrefAPIService.getDropdown();

    _initialLocationLeakFound = results.leakLocations;
    _verificationLocationLeakFound = results.leakLocations;
    _categoriesLeakFound = results.leakLocationCategories;
    _causeOfLeaks = results.causeOfLeaks;
    _leakDetectionMethod = results.leakDetectionMethods;
    _serviceTransferReason = results.purposesForAddingGas;

    _serviceActions = results.serviceActions;
    _leakRepairStatus = results.leakRepairStatuses;
    
    setState(ViewState.Idle);
  }
}