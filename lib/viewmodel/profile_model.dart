import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class ProfileModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  InfoUser currentProfile;

  fetchProfile() async {
    setState(ViewState.Busy);
    currentProfile = await _api.getSelectedProfile();
    setState(ViewState.Idle);
  }
}