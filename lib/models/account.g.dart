// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
      name: json['Name'] as String,
      instanceID: json['InstanceID'] as int,
      accountTypeID: json['AccountTypeID'] as int,
      accountType: json['AccountType'] as String,
      address1: json['Address1'] as String,
      address2: json['Address2'] as String,
      city: json['City'] as String,
      state: json['State'] as String,
      zipcode: json['Zipcode'] as String,
      country: json['Country'] as String,
      industryTypeID: json['IndustryTypeID'] as int,
      industryType: json['IndustryType'] as String,
      status: json['Status'] as int,
      statusName: json['StatusName'] as String,
      contactID: json['ContactID'] as int,
      contactName: json['ContactName'] as String,
      contactPhone: json['ContactPhone'] as String,
      contactEmail: json['ContactEmail'] as String,
      ID: json['ID'] as int);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'Name': instance.name,
      'InstanceID': instance.instanceID,
      'AccountTypeID': instance.accountTypeID,
      'AccountType': instance.accountType,
      'Address1': instance.address1,
      'Address2': instance.address2,
      'City': instance.city,
      'State': instance.state,
      'Zipcode': instance.zipcode,
      'Country': instance.country,
      'IndustryTypeID': instance.industryTypeID,
      'IndustryType': instance.industryType,
      'Status': instance.status,
      'StatusName': instance.statusName,
      'ContactID': instance.contactID,
      'ContactName': instance.contactName,
      'ContactPhone': instance.contactPhone,
      'ContactEmail': instance.contactEmail,
      'ID': instance.ID
    };
