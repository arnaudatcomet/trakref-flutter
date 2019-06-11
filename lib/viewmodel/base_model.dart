import 'package:flutter/cupertino.dart';
import 'package:trakref_app/enums/viewstate.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  
  setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}