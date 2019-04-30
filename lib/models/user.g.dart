// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      groupID: json['GroupID'] as int,
      instanceID: json['InstanceID'] as int,
      userId: json['UserId'] as String,
      username: json['Username'] as String,
      password: json['Password'] as String,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      fullName: json['FullName'] as String,
      title: json['Title'] as String,
      description: json['Description'] as String,
      adress1: json['Address1'] as String,
      address2: json['Address2'] as String,
      city: json['City'] as String,
      county: json['County'] as String,
      state: json['State'] as String,
      zip: json['Zip'] as String,
      country: json['Country'] as String,
      phone: json['Phone'] as String,
      cell: json['Cell'] as String,
      email: json['Email'] as String,
      fax: json['Fax'] as String,
      certificationType: json['CertificationType'] as String,
      certificateNumber: json['CertificateNumber'] as String,
      weightUnits: json['WeightUnits'] as String,
      hasOtherInstances: json['HasOtherInstances'] as bool,
      restrictedLocations: json['RestrictedLocations'] as bool,
      requireAdminApproval: json['RequireAdminApproval'] as bool,
      company: json['Company'] as String,
      isTechnician: json['IsTechnician'] as bool,
      manageInventoryPermissions: json['ManageInventoryPermissions'] as int,
      manageLocationsPermissions: json['ManageLocationsPermissions'] as int,
      canAddWorkOrder: json['CanAddWorkOrder'] as bool,
      canAddServiceEvent: json['CanAddServiceEvent'] as bool,
      isTrakrefEmployee: json['IsTrakrefEmployee'] as bool,
      preferredLeakDetectionMethodID:
          json['PreferredLeakDetectionMethodID'] as int,
      preferredLeakDetectionMethod:
          json['PreferredLeakDetectionMethod'] as String,
      ID: json['ID'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'GroupID': instance.groupID,
      'InstanceID': instance.instanceID,
      'UserId': instance.userId,
      'Username': instance.username,
      'Password': instance.password,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'FullName': instance.fullName,
      'Title': instance.title,
      'Description': instance.description,
      'Address1': instance.adress1,
      'Address2': instance.address2,
      'City': instance.city,
      'County': instance.county,
      'State': instance.state,
      'Zip': instance.zip,
      'Country': instance.country,
      'Phone': instance.phone,
      'Cell': instance.cell,
      'Email': instance.email,
      'Fax': instance.fax,
      'CertificationType': instance.certificationType,
      'CertificateNumber': instance.certificateNumber,
      'WeightUnits': instance.weightUnits,
      'HasOtherInstances': instance.hasOtherInstances,
      'RestrictedLocations': instance.restrictedLocations,
      'RequireAdminApproval': instance.requireAdminApproval,
      'Company': instance.company,
      'IsTechnician': instance.isTechnician,
      'ManageInventoryPermissions': instance.manageInventoryPermissions,
      'ManageLocationsPermissions': instance.manageLocationsPermissions,
      'CanAddWorkOrder': instance.canAddWorkOrder,
      'CanAddServiceEvent': instance.canAddServiceEvent,
      'IsTrakrefEmployee': instance.isTrakrefEmployee,
      'PreferredLeakDetectionMethodID': instance.preferredLeakDetectionMethodID,
      'PreferredLeakDetectionMethod': instance.preferredLeakDetectionMethod,
      'ID': instance.ID
    };
