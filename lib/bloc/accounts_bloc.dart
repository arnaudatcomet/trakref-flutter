import 'dart:async';

import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api_service.dart';

class AccountsBloc implements BlocBase {
  ApiService _apiService = ApiService();
  int currentInstanceID = 0;
  List<Account> _account;

  StreamController<int> _triggerController = StreamController<int>.broadcast();
  Sink<int> get startRetrievingAccount => _triggerController.sink;

  StreamController<List<Account>> _getAccountsController = StreamController<List<Account>>.broadcast();
  Sink<List<Account>> get retrievingAccount => _getAccountsController.sink;
  Stream<List<Account>> get getRetrievingAccount => _getAccountsController.stream;

  AccountsBloc({this.currentInstanceID}) {
    print("_AccountsBloc($currentInstanceID)");
    if (currentInstanceID != null) {
      _triggerController.stream.listen(_startAccount);
      _getAccountsController.stream.listen(_retrievingAccount);
    }
  }

  void _startAccount(int instanceID) {
    print("_startAccount($instanceID)");
    _getAccountsController.add([]);

    _apiService.getResult<Account>(ApiService.getAccountsURL).then((response){
      print("getResult > (${response})");
      _account = response;
      retrievingAccount.add(_account);
    }).catchError((error){
      _getAccountsController.addError(error);
    });
  }

  void _retrievingAccount(List<Account> account) {
//    print("_retrievingAccount(${account.length})");
  }

  @override
  void dispose() {
  }
}