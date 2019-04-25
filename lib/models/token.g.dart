// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
      token: json['Token'] as String,
      userID: json['UserID'] as int,
      userGUID: json['UserGUID'] as String);
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'Token': instance.token,
      'UserID': instance.userID,
      'UserGUID': instance.userGUID
    };
