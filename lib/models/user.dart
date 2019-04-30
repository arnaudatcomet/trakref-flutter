import 'package:json_annotation/json_annotation.dart';
import 'package:trakref_app/models/token.dart';
import 'package:trakref_app/models/user.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'GroupID')
  final int groupID;

  @JsonKey(name: 'InstanceID')
  final int instanceID;

  @JsonKey(name: 'UserId')
  final String userId;

  @JsonKey(name: 'Username')
  final String username;

  @JsonKey(name: 'Password', nullable: true)
  final String password;

  @JsonKey(name: 'FirstName')
  final String firstName;

  @JsonKey(name: 'LastName')
  final String lastName;

  @JsonKey(name: 'FullName')
  final String fullName;

  @JsonKey(name: 'Title')
  final String title;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'Address1')
  final String adress1;

  @JsonKey(name: 'Address2')
  final String address2;

  @JsonKey(name: 'City')
  final String city;

  @JsonKey(name: 'County')
  final String county;

  @JsonKey(name: 'State')
  final String state;

  @JsonKey(name: 'Zip')
  final String zip;

  @JsonKey(name: 'Country')
  final String country;

  @JsonKey(name: 'Phone')
  final String phone;

  @JsonKey(name: 'Cell')
  final String cell;

  @JsonKey(name: 'Email')
  final String email;

  @JsonKey(name: 'Fax')
  final String fax;

  @JsonKey(name: 'CertificationType')
  final String certificationType;

  @JsonKey(name: 'CertificateNumber')
  final String certificateNumber;

  @JsonKey(name: 'WeightUnits')
  final String weightUnits;

  @JsonKey(name: 'HasOtherInstances')
  final bool hasOtherInstances;

  @JsonKey(name: 'RestrictedLocations')
  final bool restrictedLocations;

  @JsonKey(name: 'RequireAdminApproval')
  final bool requireAdminApproval;

  @JsonKey(name: 'Company')
  final String company;

  @JsonKey(name: 'IsTechnician')
  final bool isTechnician;

  @JsonKey(name: 'ManageInventoryPermissions')
  final int manageInventoryPermissions;

  @JsonKey(name: 'ManageLocationsPermissions')
  final int manageLocationsPermissions;

  @JsonKey(name: 'CanAddWorkOrder')
  final bool canAddWorkOrder;

  @JsonKey(name: 'CanAddServiceEvent')
  final bool canAddServiceEvent;

  @JsonKey(name: 'IsTrakrefEmployee')
  final bool isTrakrefEmployee;

  @JsonKey(name: 'PreferredLeakDetectionMethodID')
  final int preferredLeakDetectionMethodID;

  @JsonKey(name: 'PreferredLeakDetectionMethod')
  final String preferredLeakDetectionMethod;

  @JsonKey(name: 'ID')
  final int ID;

  User({this.groupID, this.instanceID, this.userId, this.username, this.password, this.firstName, this.lastName,
    this.fullName, this.title, this.description, this.adress1, this.address2,
    this.city, this.county, this.state, this.zip, this.country, this.phone,
    this.cell, this.email, this.fax, this.certificationType,
    this.certificateNumber, this.weightUnits, this.hasOtherInstances,
    this.restrictedLocations, this.requireAdminApproval, this.company,
    this.isTechnician, this.manageInventoryPermissions,
    this.manageLocationsPermissions, this.canAddWorkOrder,
    this.canAddServiceEvent, this.isTrakrefEmployee,
    this.preferredLeakDetectionMethodID, this.preferredLeakDetectionMethod,
    this.ID});

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
