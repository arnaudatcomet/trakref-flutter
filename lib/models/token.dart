import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'UserID')
  final int userID;

  @JsonKey(name: 'UserGUID')
  final String userGUID;


  Token({this.token, this.userID, this.userGUID});

  factory Token.fromJson(Map<String, dynamic> json) =>
      _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}