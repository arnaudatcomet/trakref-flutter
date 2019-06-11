import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class AccountsModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  List<Account> accounts;
  TextEditingController controller;

  Future fetchAccounts() async {
    setState(ViewState.Busy);
    accounts = await _api.getAccounts();
    setState(ViewState.Idle);
  }

  List<Account> fetchAccountFromSearch(String searching) {
    if (accounts == null) 
      return [];

    print("accounts $searching in ${accounts.length}");
    return accounts.where((account) => account.name.contains(searching)).toList();
  }

  List<Account> fetchFromSearch(List<Account> items, String searching) {
    if (items == null) 
      return [];

    return items.where((account) => account.name.contains(searching)).toList();
  }
}