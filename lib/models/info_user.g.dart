// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoUser _$InfoUserFromJson(Map<String, dynamic> json) {
  return InfoUser(
      token: json['token'] == null
          ? null
          : Token.fromJson(json['token'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      errorMessage: json['Message'] as String);
}

Map<String, dynamic> _$InfoUserToJson(InfoUser instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'Message': instance.errorMessage
    };
