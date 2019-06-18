// TODO : we need to move that to a proper caching service for flutter
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';

class CachingAPIService {
  static final CachingAPIService _shared = new CachingAPIService._internal();

  factory CachingAPIService() {
    return _shared;
  }

  CachingAPIService._internal();

  // Services
  TrakrefAPIService _api = TrakrefAPIService();

  // Cached properties. Notes from Arnaud : Need to be moved to key/value or by URL instead of properties
  List<Account> _cachedAccounts;
  List<Account> get cachedAccounts => _cachedAccounts;
  clearCachedAccount() => _cachedAccounts = null;

  DropdownList _cachedDropdowns;
  DropdownList get cachedDropdowns => _cachedDropdowns;
  clearCachedDropdowns() => _cachedDropdowns = null;

  List<WorkOrder> _cachedServiceEvents;
  List<WorkOrder> get cachedServiceEvents => _cachedServiceEvents;
  clearServiceEvents() => _cachedServiceEvents = null;

  Future<List<Account>> fetchCachedAccount() async {
    _cachedAccounts = await _api.getAccounts();
    return _cachedAccounts;
  }

  Future<DropdownList> fetchCachedDropdowns() async {
    _cachedDropdowns = await _api.getDropdown();
    return _cachedDropdowns;
  }

  Future<List<WorkOrder>> fetchCachedServiceEvents() async {
    _cachedServiceEvents = await _api.getServiceEvents([]);
    return _cachedServiceEvents;
  }
}
