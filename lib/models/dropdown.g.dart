// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropdownList _$DropdownListFromJson(Map<String, dynamic> json) {
  return DropdownList(
      serviceActions: (json['serviceActions'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      assetStatuses: (json['assetStatuses'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      coolingApplianceStatuses: (json['coolingApplianceStatuses'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      assetTypes: (json['assetTypes'] as List)
          ?.map((e) => e == null
              ? null
              : AssetTypeItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      assetSubtypes: (json['assetSubtypes'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      workItemStatuses: (json['workItemStatuses'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      workItemTypes: (json['workItemTypes'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      leakDetectionMethods: (json['leakDetectionMethods'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      purposesForAddingGas: (json['purposesForAddingGas'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      materialTypes: (json['materialTypes'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      materialStatuses: (json['materialStatuses'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      leakRepairStatuses: (json['leakRepairStatuses'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      leakLocationCategories: (json['leakLocationCategories'] as List)
          ?.map((e) => e == null
              ? null
              : DropdownItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      leakLocations: (json['leakLocations'] as List)
          ?.map((e) => e == null ? null : LeakLocationItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      causeOfLeaks: (json['causeOfLeaks'] as List)?.map((e) => e == null ? null : DropdownItem.fromJson(e as Map<String, dynamic>))?.toList(),
      accountStatuses: (json['accountStatuses'] as List)?.map((e) => e == null ? null : DropdownItem.fromJson(e as Map<String, dynamic>))?.toList(),
      industryTypes: (json['industryTypes'] as List)?.map((e) => e == null ? null : DropdownItem.fromJson(e as Map<String, dynamic>))?.toList(),
      temperatureClasses: (json['temperatureClasses'] as List)?.map((e) => e == null ? null : DropdownItem.fromJson(e as Map<String, dynamic>))?.toList(),
      chargeCapacitySourceTypes: (json['chargeCapacitySourceTypes'] as List)?.map((e) => e == null ? null : DropdownItem.fromJson(e as Map<String, dynamic>))?.toList());
}

Map<String, dynamic> _$DropdownListToJson(DropdownList instance) =>
    <String, dynamic>{
      'serviceActions': instance.serviceActions,
      'assetStatuses': instance.assetStatuses,
      'coolingApplianceStatuses': instance.coolingApplianceStatuses,
      'assetTypes': instance.assetTypes,
      'assetSubtypes': instance.assetSubtypes,
      'workItemStatuses': instance.workItemStatuses,
      'workItemTypes': instance.workItemTypes,
      'leakDetectionMethods': instance.leakDetectionMethods,
      'purposesForAddingGas': instance.purposesForAddingGas,
      'materialTypes': instance.materialTypes,
      'materialStatuses': instance.materialStatuses,
      'leakRepairStatuses': instance.leakRepairStatuses,
      'leakLocationCategories': instance.leakLocationCategories,
      'leakLocations': instance.leakLocations,
      'causeOfLeaks': instance.causeOfLeaks,
      'accountStatuses': instance.accountStatuses,
      'industryTypes': instance.industryTypes,
      'temperatureClasses': instance.temperatureClasses,
      'chargeCapacitySourceTypes': instance.chargeCapacitySourceTypes
    };

DropdownItem _$DropdownItemFromJson(Map<String, dynamic> json) {
  return DropdownItem(name: json['Name'] as String, id: json['ID'] as int);
}

Map<String, dynamic> _$DropdownItemToJson(DropdownItem instance) =>
    <String, dynamic>{'Name': instance.name, 'ID': instance.id};

AssetTypeItem _$AssetTypeItemFromJson(Map<String, dynamic> json) {
  return AssetTypeItem(
      name: json['Name'] as String,
      id: json['ID'] as int,
      isCylinder: json['IsCylinder'] as bool);
}

Map<String, dynamic> _$AssetTypeItemToJson(AssetTypeItem instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'ID': instance.id,
      'IsCylinder': instance.isCylinder
    };

LeakLocationItem _$LeakLocationItemFromJson(Map<String, dynamic> json) {
  return LeakLocationItem(
      id: json['ID'] as int,
      name: json['Name'] as String,
      category: json['Category'] as String,
      categoryID: json['CategoryID'] as int);
}

Map<String, dynamic> _$LeakLocationItemToJson(LeakLocationItem instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'Category': instance.category,
      'CategoryID': instance.categoryID
    };
