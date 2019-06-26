import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class AccountsModel extends BaseModel {
  CachingAPIService _cachedApi = CachingAPIService();
  TrakrefAPIService _api = TrakrefAPIService();
  List<Account> get accounts => _accounts;
  List<Account> _accounts;

  String get currentInstanceID => _currentInstanceID;
  String _currentInstanceID;

  TextEditingController controller;

  refreshAccounts() async {
    _cachedApi.clearCachedAccount();
    fetchAccounts();
  }

  fetchAccounts() async {
    setState(ViewState.Busy);
    if (_cachedApi.cachedAccounts == null) {
      _accounts = await _cachedApi.fetchCachedAccount();
    } else {
      _accounts = _cachedApi.cachedAccounts;
    }
    setState(ViewState.Idle);
  }

  fetchCurrentAccount() async {
    setState(ViewState.Busy);
    _currentInstanceID = await _api.getInstanceID();
    setState(ViewState.Idle);
  }

  List<Account> fetchAccountFromSearch(String searching) {
    return fetchFromSearch(accounts, searching);
  }

  List<Account> fetchFromSearch(List<Account> items, String searching) {
    if (items == null) return [];

    return items.where((account) => account.name.contains(searching)).toList();
  }

  selectAccount(int instanceID) {
    Account selectedAccount = (accounts ?? [])
        .where((Account account) => account.instanceID == instanceID)
        .first;
    // Clear the current work order
    _api.setWorkOrder(null);
    
    // Save the instanceID and selected account
    _api.setSelectedAccount(selectedAccount);
    _api.setInstanceID(selectedAccount.instanceID.toString());
  }
}
