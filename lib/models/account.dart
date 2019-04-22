import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'InstanceID')
  final int instanceID;

  @JsonKey(name: 'AccountTypeID')
  final int accountTypeID;

  @JsonKey(name: 'AccountType')
  final String accountType;

  @JsonKey(name: 'Address1')
  final String address1;

  @JsonKey(name: 'Address2')
  final String address2;

  @JsonKey(name: 'City')
  final String city;

  @JsonKey(name: 'State')
  final String state;

  @JsonKey(name: 'Zipcode')
  final String zipcode;

  @JsonKey(name: 'Country')
  final String country;

  @JsonKey(name: 'IndustryTypeID')
  final int industryTypeID;

  @JsonKey(name: 'IndustryType')
  final String industryType;

  @JsonKey(name: 'Status')
  final int status;

  @JsonKey(name: 'StatusName')
  final String statusName;

  @JsonKey(name: 'ContactID')
  final int contactID;

  @JsonKey(name: 'ContactName')
  final String contactName;

  @JsonKey(name: 'ContactPhone')
  final String contactPhone;

  @JsonKey(name: 'ContactEmail')
  final String contactEmail;

  @JsonKey(name: 'ID')
  final int ID;

  Account({this.name, this.instanceID, this.accountTypeID, this.accountType,
    this.address1, this.address2, this.city, this.state, this.zipcode,
    this.country, this.industryTypeID, this.industryType, this.status,
    this.statusName, this.contactID, this.contactName, this.contactPhone,
    this.contactEmail, this.ID});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  int get hashCode => instanceID.hashCode;

  @override
  bool operator ==(Object other) => other is Account && other.instanceID == instanceID;
}