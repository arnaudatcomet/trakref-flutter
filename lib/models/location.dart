import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'InstanceID')
  final int instanceID;

  @JsonKey(name: 'AssociationGUID')
  final String associationGUID;

  @JsonKey(name: 'LocationTypeID')
  final int locationTypeID;

  @JsonKey(name: 'ContactFirstName')
  final String contactFirstName;

  @JsonKey(name: 'ContactLastName')
  final String contactLastName;

  @JsonKey(name: 'MailingAddress1')
  final String mailingAddress1;

  @JsonKey(name: 'MailingCity')
  final String mailingCity;

  @JsonKey(name: 'MailingState')
  final String mailingState;

  @JsonKey(name: 'MailingZip')
  final String mailingZip;

  @JsonKey(name: 'MailingCountry')
  final String mailingCountry;

  @JsonKey(name: 'PhysicalAddress1')
  final String physicalAddress1;

  @JsonKey(name: 'PhysicalCity')
  final String physicalCity;

  @JsonKey(name: 'PhysicalState')
  final String physicalState;

  @JsonKey(name: 'PhysicalZip')
  final String physicalZip;

  @JsonKey(name: 'PhysicalCountry')
  final String physicalCountry;

  @JsonKey(name: 'Additional')
  final String additional;

  @JsonKey(name: 'IsSupplier')
  final bool isSupplier;

  @JsonKey(name: 'IsDestructor')
  final bool isDestructor;

  @JsonKey(name: 'IsServicer')
  final bool isServicer;

  @JsonKey(name: 'Lat')
  final double lat;

  @JsonKey(name: 'Long')
  final double long;

  @JsonKey(name: 'IsOffsite')
  final bool isOffsite;

  @JsonKey(name: 'ID')
  final int ID;

  @JsonKey(name: 'ContactPhone')
  final String contactPhone;

  double distance = 0;

  Location({this.name, this.code, this.instanceID, this.associationGUID,
    this.locationTypeID, this.contactFirstName, this.contactLastName,
    this.mailingAddress1, this.mailingCity, this.mailingState,
    this.mailingZip, this.mailingCountry, this.physicalAddress1,
    this.physicalCity, this.physicalState, this.physicalZip, this.distance,
    this.physicalCountry, this.additional, this.isSupplier, this.isDestructor,
    this.isServicer, this.lat, this.long, this.isOffsite, this.ID, this.contactPhone});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  int get hashCode => ID.hashCode;

  @override
  bool operator ==(Object other) => other is Location && other.ID == ID;
}