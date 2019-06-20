import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class AccountsModel extends BaseModel {
  CachingAPIService _cachedApi = CachingAPIService();
  List<Account> accounts;
  TextEditingController controller;

  refreshAccounts() async {
    _cachedApi.clearCachedAccount();
    fetchAccounts();
  }

  fetchAccounts() async {
    setState(ViewState.Busy);
    if (_cachedApi.cachedAccounts == null) {
      accounts = await _cachedApi.fetchCachedAccount();
    }
    else {
      accounts = _cachedApi.cachedAccounts;
    }
    setState(ViewState.Idle);
  }

  List<Account> fetchAccountFromSearch(String searching) {
    return fetchFromSearch(accounts, searching);
  }

  List<Account> fetchFromSearch(List<Account> items, String searching) {
    if (items == null) return [];

    return items.where((account) => account.name.contains(searching)).toList();
  }
}
