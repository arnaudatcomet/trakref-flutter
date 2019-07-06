// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zdrequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZDRequestPost _$ZDRequestPostFromJson(Map<String, dynamic> json) {
  return ZDRequestPost(
      request: json['request'] == null
          ? null
          : ZDRequest.fromJson(json['request'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ZDRequestPostToJson(ZDRequestPost instance) =>
    <String, dynamic>{'request': instance.request};

ZDRequest _$ZDRequestFromJson(Map<String, dynamic> json) {
  return ZDRequest(
      requester: json['requester'] == null
          ? null
          : ZDRequester.fromJson(json['requester'] as Map<String, dynamic>),
      customFields: (json['custom_fields'] as List)
          ?.map((e) => e == null
              ? null
              : ZDCustomFields.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      subject: json['subject'] as String,
      comment: json['comment'] == null
          ? null
          : ZDRequestComment.fromJson(json['comment'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ZDRequestToJson(ZDRequest instance) => <String, dynamic>{
      'requester': instance.requester,
      'custom_fields': instance.customFields,
      'subject': instance.subject,
      'comment': instance.comment
    };

ZDRequestComment _$ZDRequestCommentFromJson(Map<String, dynamic> json) {
  return ZDRequestComment(body: json['body'] as String);
}

Map<String, dynamic> _$ZDRequestCommentToJson(ZDRequestComment instance) =>
    <String, dynamic>{'body': instance.body};

ZDCustomFields _$ZDCustomFieldsFromJson(Map<String, dynamic> json) {
  return ZDCustomFields(id: json['id'] as int, value: json['value'] as String);
}

Map<String, dynamic> _$ZDCustomFieldsToJson(ZDCustomFields instance) =>
    <String, dynamic>{'id': instance.id, 'value': instance.value};

ZDRequester _$ZDRequesterFromJson(Map<String, dynamic> json) {
  return ZDRequester(name: json['name'] as String);
}

Map<String, dynamic> _$ZDRequesterToJson(ZDRequester instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  return val;
}
