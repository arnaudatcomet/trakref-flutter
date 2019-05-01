import 'package:shared_preferences/shared_preferences.dart';
import 'package:trakref_app/models/search_filter_options.dart';

class FilterPreferenceService {
  static final FilterPreferenceService _shared = new FilterPreferenceService._internal();

  factory FilterPreferenceService() {
    return _shared;
  }

  FilterPreferenceService._internal();

  String _getPreferenceKeys(SearchFilterOptions options) {
    switch (options) {
      case SearchFilterOptions.AroundMe:
        return "AroundMeFilter";
      case SearchFilterOptions.AssignedToMe:
        return "AssignedToMeFilter";
      case SearchFilterOptions.Opened:
        return "OpenedFilter";
    }
    return "";
  }

  resetAll() {
    setFilter(SearchFilterOptions.AroundMe, false);
    setFilter(SearchFilterOptions.AssignedToMe, false);
    setFilter(SearchFilterOptions.Opened, false);
  }

  Future<bool> getValues(SearchFilterOptions options) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_getPreferenceKeys(options));
  }

  setFilter(SearchFilterOptions options, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_getPreferenceKeys(options), value);
  }
}
