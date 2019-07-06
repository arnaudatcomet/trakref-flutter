import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/info_user.dart';
import 'package:trakref_app/models/zdrequest.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api/zendesk_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class ZendeskSupportModel extends BaseModel {
  ZendeskAPIService _zendeskAPIService = ZendeskAPIService();
  TrakrefAPIService _trakrefAPIService = TrakrefAPIService();
  InfoUser _currentUser;

  // Phone Number
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;

  // Subject
  TextEditingController _subjectController = TextEditingController();
  TextEditingController get subjectController => _subjectController;

  // Description
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  fetchCurrentProfile() async {
    setState(ViewState.Busy);
    _currentUser = await _trakrefAPIService.getSelectedProfile();
    setState(ViewState.Idle);
  }

  submit(ZDRequestType type, {Function onDone, Function onError}) async {
    String subject = _subjectController.text;
    String description = _descriptionController.text;
    String phoneNumber = _phoneNumberController.text;

    ZDRequestPost request = ZDRequestPost.createRequestPost(type,
        subject: subject,
        fullName: _currentUser.user.fullName,
        email: _currentUser.user.email,
        description: description,
        phoneNumber: phoneNumber);

    print("ZDRequest submit > ${request.toJson()}");

    Map<String, dynamic> result = request.toJson();
    print("subject ${request.request.subject}");
    print("comment ${request.request.comment.body}");
    request.request.customFields.forEach((r) => print("id  ${r.id}, value ${r.value}"));
    print("PageSettingsBloc > result : $result");

    print("Subject : $subject");
    print("Description : $description");

    setState(ViewState.Busy);
    _zendeskAPIService.postNewRequest(request).then((result) {
      setState(ViewState.Idle);
      print("post Zendesk New Request result $result");
      if (onDone != null) {
        onDone();
      }
    }).catchError((error) {
      print("post Zendesk New error result $error");
      setState(ViewState.Idle);
      if (onError != null) {
        onError(error);
      }
    });
  }
}
