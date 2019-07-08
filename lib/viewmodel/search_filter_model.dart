import 'package:trakref_app/models/search_filter_options.dart';
import 'package:trakref_app/repository/preferences_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class SearchFilterModel extends BaseModel {
  bool _shouldShowAroundMe = false;
  bool get shouldShowAroundMe => _shouldShowAroundMe;

  bool _shouldShowOpenedServiceEvent = false;
  bool get shouldShowOpenedServiceEvent => _shouldShowOpenedServiceEvent;

  Function showAroundMeChanged;
  Function showOptionChanged;

  setSearchOption(SearchFilterOptions option, bool value) async {
    bool oldValue = await FilterPreferenceService().getValues(option);
    print("=== old value '$oldValue' and new value '$value' for option '$option === ");
    if (oldValue != value && showOptionChanged != null) {
      showOptionChanged(option, value); 
    }
    FilterPreferenceService().setFilter(option, value);
    notifyListeners();
  }
}
