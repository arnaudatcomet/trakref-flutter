import 'package:json_annotation/json_annotation.dart';

part 'zdrequest.g.dart';


@JsonSerializable()
class ZDRequestPost {
  @JsonKey(name: 'request')
  ZDRequest request;

  ZDRequestPost({this.request});

  factory ZDRequestPost.fromJson(Map<String, dynamic> json) =>
      _$ZDRequestPostFromJson(json);
  Map<String, dynamic> toJson() => _$ZDRequestPostToJson(this);


  static ZDRequestPost createRequestPost(ZDRequestType requestType, {String subject, String comment, String email, String fullName, String description, String refrigerantWeight, String systemName, String serialNumber, String gasType, String phoneNumber}) {
    ZDRequestPost post = ZDRequestPost();
    ZDRequest request = ZDRequest.createRequest(requestType, 
    subject: subject, 
    comment: comment, 
    email: email, 
    fullName: fullName,
    description: description, 
    refrigerantWeight: refrigerantWeight, 
    systemName: systemName,
    serialNumber: serialNumber, 
    gasType: gasType, 
    phoneNumber: phoneNumber);
    post.request = request;
    return post;
  }
}

@JsonSerializable()
class ZDRequest {
  @JsonKey(name: 'requester')
  ZDRequester requester;

  @JsonKey(name: 'custom_fields')
  List<ZDCustomFields> customFields;

  @JsonKey(name: 'subject')
  String subject;

  @JsonKey(name: 'comment')
  ZDRequestComment comment;

  ZDRequest({this.requester, this.customFields, this.subject, this.comment});

  static ZDRequest createRequest(ZDRequestType requestType, {String subject, String comment, String email, String fullName, String description, String refrigerantWeight, String systemName, String serialNumber, String gasType, String phoneNumber}) {
    ZDRequest request = ZDRequest();
    // Comment and description are the same for now
    String comment = description ?? "";
    String standardEmptyString = "_____";
    ZDRequestComment requestComment = ZDRequestComment(body: comment ?? "");
    ZDCustomFields fieldRequestType = ZDCustomFields.createRequestType(requestType);
    ZDCustomFields fieldUsername = ZDCustomFields.createUser(email ?? "");
    ZDCustomFields fieldFullName = ZDCustomFields.createClientName(fullName ?? "");
    ZDCustomFields fieldDescription = ZDCustomFields.createDescription(description ?? "");
    ZDCustomFields fieldRefrigerantWeight = ZDCustomFields.createRefrigerantWeight(refrigerantWeight ?? standardEmptyString);
    ZDCustomFields fieldSystemName = ZDCustomFields.createSystemName(systemName?? standardEmptyString);
    ZDCustomFields fieldSerialNumber = ZDCustomFields.createSerialNumber(serialNumber ?? standardEmptyString);
    ZDCustomFields fieldGasType = ZDCustomFields.createGasType(gasType ?? standardEmptyString);
    ZDCustomFields fieldPhoneNumber = ZDCustomFields.createPhoneNumber(phoneNumber ?? ""); 
    
    ZDRequester requester = ZDRequester();
    requester.name = fullName ?? "";

    // Attach to custom fields
    request.customFields = [
      fieldRequestType,
      fieldUsername,
      fieldFullName,
      fieldDescription,
      fieldRefrigerantWeight,
      fieldSystemName,
      fieldSerialNumber,
      fieldGasType,
      fieldPhoneNumber
    ];

    request.requester = requester;

    // Add Subject and Comment
    request.comment = requestComment;
    request.subject = subject ?? "";
    return request;
  }

  // String utility for ZDRequestType
  static String getRequestTypeFormattedString(ZDRequestType type) {
    String typeString = "";
    switch (type) {
      case ZDRequestType.FeatureSuggestion:
        typeString = "I have a new Trakref feature suggestion.";
        break;
      case ZDRequestType.SoftwareIssue:
        typeString = "Something isn’t working right.";
        break;
      case ZDRequestType.UsabilityAssistance:
        typeString = "I need help using Trakref.";
        break;
      case ZDRequestType.SalesLead:
        typeString = "I am interested in purchasing Trakref.";
        break;
      case ZDRequestType.OperationsOnBoarding:
        typeString = "I would like to schedule a training.";
        break;
      case ZDRequestType.OperationBillable:
        typeString = "I need help entering a service ticket.";
        break;
      default:
        typeString = "";
    }
    return typeString;
  }
  
  factory ZDRequest.fromJson(Map<String, dynamic> json) =>
      _$ZDRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ZDRequestToJson(this);
}

enum ZDRequestType { FeatureSuggestion, SoftwareIssue, UsabilityAssistance, SalesLead, OperationsOnBoarding, OperationBillable }


@JsonSerializable()
class ZDRequestComment {
  @JsonKey(name: 'body')
  final String body;

  ZDRequestComment({this.body});

  factory ZDRequestComment.fromJson(Map<String, dynamic> json) =>
      _$ZDRequestCommentFromJson(json);
  Map<String, dynamic> toJson() => _$ZDRequestCommentToJson(this);
}

@JsonSerializable()
class ZDCustomFields {
  static get kRequestTypeFieldID => 23646125;
  static get kPhoneNumberFieldID => 24271299;
  static get kClientNameFieldID => 360000151526;
  static get kUserFieldID => 360000151546;
  static get kSystemSerialNumberFieldID => 360000151566;
  static get kSystemNameFieldID => 360000153623;
  static get kGasTypeFieldID => 360000153643;
  static get kRefrigerantWeightFieldID => 360000151586;
  static get kDescriptionFieldID => 360000151606;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'value')
  final String value;

  ZDCustomFields({this.id, this.value});
  
  // Request Type
  static ZDCustomFields createRequestType(ZDRequestType type) {
    String typeString = "";
    switch (type) {
      case ZDRequestType.FeatureSuggestion:
        typeString = "feature_suggestion";
        break;
      case ZDRequestType.SoftwareIssue:
        typeString = "software_issue";
        break;
      case ZDRequestType.UsabilityAssistance:
        typeString = "usability_assistance";
        break;
      case ZDRequestType.SalesLead:
        typeString = "sales_lead";
        break;
      case ZDRequestType.OperationsOnBoarding:
        typeString = "operations_onboarding";
        break;
      case ZDRequestType.OperationBillable:
        typeString = "operations_billable";
        break;
    }
    return ZDCustomFields(id: ZDCustomFields.kRequestTypeFieldID, value: typeString);
  }

  // Username
  static ZDCustomFields createUser(String email) {
    return ZDCustomFields(id: ZDCustomFields.kUserFieldID, value: email);
  }

  // Full Client name
  static ZDCustomFields createClientName(String user) {
    return ZDCustomFields(id: ZDCustomFields.kClientNameFieldID, value: user);
  }

  // Description
  static ZDCustomFields createDescription(String description) {
    return ZDCustomFields(id: ZDCustomFields.kDescriptionFieldID, value: description);
  }

  // Refrigerant Weight
  static ZDCustomFields createRefrigerantWeight(String weight) {
    return ZDCustomFields(id: ZDCustomFields.kRefrigerantWeightFieldID, value: weight);
  }

  // Gas Type
  static ZDCustomFields createGasType(String type) {
    return ZDCustomFields(id: ZDCustomFields.kGasTypeFieldID, value: type);
  }

  // Serial Number
  static ZDCustomFields createSerialNumber(String serial) {
    return ZDCustomFields(id: ZDCustomFields.kSystemSerialNumberFieldID, value: serial);
  }

  // System Name
  static ZDCustomFields createSystemName(String system) {
    return ZDCustomFields(id: ZDCustomFields.kSystemNameFieldID, value: system);
  }

  // Phone Number
  static ZDCustomFields createPhoneNumber(String phone) {
    return ZDCustomFields(id: ZDCustomFields.kPhoneNumberFieldID, value: phone);
  }

  factory ZDCustomFields.fromJson(Map<String, dynamic> json) =>
      _$ZDCustomFieldsFromJson(json);
  Map<String, dynamic> toJson() => _$ZDCustomFieldsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ZDRequester {
  @JsonKey(name: 'name')
  String name;

  ZDRequester({this.name});

  factory ZDRequester.fromJson(Map<String, dynamic> json) =>
      _$ZDRequesterFromJson(json);
  Map<String, dynamic> toJson() => _$ZDRequesterToJson(this);
}
