import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/models/search_filter_options.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/preferences_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class SearchFilterModel extends BaseModel {
  bool _shouldShowAroundMe = false;
  bool get shouldShowAroundMe => _shouldShowAroundMe;
  // Function onShowAroundMe;
  Function showAroundMeChanged;

  setAroundMe(bool show) {
    if (show != _shouldShowAroundMe) {
      showAroundMeChanged(show);
    }
    _shouldShowAroundMe = show;
    FilterPreferenceService().setFilter(SearchFilterOptions.AroundMe, show);
    notifyListeners();
  }

  showAroundMe() {
    setAroundMe(true);
  }

  dontShowAroundMe() {
    setAroundMe(false);
  }
}
