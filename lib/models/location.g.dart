// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      name: json['Name'] as String,
      code: json['Code'] as String,
      instanceID: json['InstanceID'] as int,
      associationGUID: json['AssociationGUID'] as String,
      locationTypeID: json['LocationTypeID'] as int,
      contactFirstName: json['ContactFirstName'] as String,
      contactLastName: json['ContactLastName'] as String,
      mailingAddress1: json['MailingAddress1'] as String,
      mailingCity: json['MailingCity'] as String,
      mailingState: json['MailingState'] as String,
      mailingZip: json['MailingZip'] as String,
      mailingCountry: json['MailingCountry'] as String,
      physicalAddress1: json['PhysicalAddress1'] as String,
      physicalCity: json['PhysicalCity'] as String,
      physicalState: json['PhysicalState'] as String,
      physicalZip: json['PhysicalZip'] as String,
      distance: (json['distance'] as num)?.toDouble(),
      physicalCountry: json['PhysicalCountry'] as String,
      additional: json['Additional'] as String,
      isSupplier: json['IsSupplier'] as bool,
      isDestructor: json['IsDestructor'] as bool,
      isServicer: json['IsServicer'] as bool,
      lat: (json['Lat'] as num)?.toDouble(),
      long: (json['Long'] as num)?.toDouble(),
      isOffsite: json['IsOffsite'] as bool,
      ID: json['ID'] as int,
      contactPhone: json['ContactPhone'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'Name': instance.name,
      'Code': instance.code,
      'InstanceID': instance.instanceID,
      'AssociationGUID': instance.associationGUID,
      'LocationTypeID': instance.locationTypeID,
      'ContactFirstName': instance.contactFirstName,
      'ContactLastName': instance.contactLastName,
      'MailingAddress1': instance.mailingAddress1,
      'MailingCity': instance.mailingCity,
      'MailingState': instance.mailingState,
      'MailingZip': instance.mailingZip,
      'MailingCountry': instance.mailingCountry,
      'PhysicalAddress1': instance.physicalAddress1,
      'PhysicalCity': instance.physicalCity,
      'PhysicalState': instance.physicalState,
      'PhysicalZip': instance.physicalZip,
      'PhysicalCountry': instance.physicalCountry,
      'Additional': instance.additional,
      'IsSupplier': instance.isSupplier,
      'IsDestructor': instance.isDestructor,
      'IsServicer': instance.isServicer,
      'Lat': instance.lat,
      'Long': instance.long,
      'IsOffsite': instance.isOffsite,
      'ID': instance.ID,
      'ContactPhone': instance.contactPhone,
      'distance': instance.distance
    };
