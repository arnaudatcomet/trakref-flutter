import 'package:json_annotation/json_annotation.dart';
import 'package:trakref_app/models/token.dart';
import 'package:trakref_app/models/user.dart';

part 'info_user.g.dart';

@JsonSerializable()
class InfoUser {
  @JsonKey(name: 'token')
  final Token token;

  @JsonKey(name: 'user')
  final User user;

  // This is for error message
  @JsonKey(name: 'Message', nullable: true)
  final String errorMessage;

  InfoUser({this.token, this.user, this.errorMessage});

  factory InfoUser.fromJson(Map<String, dynamic> json) =>
      _$InfoUserFromJson(json);
  Map<String, dynamic> toJson() => _$InfoUserToJson(this);
}