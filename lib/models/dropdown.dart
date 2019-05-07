import 'package:json_annotation/json_annotation.dart';

part 'dropdown.g.dart';

@JsonSerializable()
class DropdownList {
  @JsonKey(nullable: true, name: "serviceActions")
  List<DropdownItem> serviceActions;

  @JsonKey(nullable: true, name: "assetStatuses")
  List<DropdownItem> assetStatuses;

  @JsonKey(nullable: true, name: "coolingApplianceStatuses")
  List<DropdownItem> coolingApplianceStatuses;

  @JsonKey(nullable: true, name: "assetTypes")
  List<AssetTypeItem> assetTypes;

  @JsonKey(nullable: true, name: "assetSubtypes")
  List<DropdownItem> assetSubtypes;

  @JsonKey(nullable: true, name: "workItemStatuses")
  List<DropdownItem> workItemStatuses;

  @JsonKey(nullable: true, name: "workItemTypes")
  List<DropdownItem> workItemTypes;

  @JsonKey(nullable: true, name: "leakDetectionMethods")
  List<DropdownItem> leakDetectionMethods;

  @JsonKey(nullable: true, name: "purposesForAddingGas")
  List<DropdownItem> purposesForAddingGas;

  @JsonKey(nullable: true, name: "materialTypes")
  List<DropdownItem> materialTypes;

  @JsonKey(nullable: true, name: "materialStatuses")
  List<DropdownItem> materialStatuses;

  @JsonKey(nullable: true, name: "leakRepairStatuses")
  List<DropdownItem> leakRepairStatuses;

  @JsonKey(nullable: true, name: "leakLocationCategories")
  List<DropdownItem> leakLocationCategories;

  @JsonKey(nullable: true, name: "leakLocations")
  List<LeakLocationItem> leakLocations;

  @JsonKey(nullable: true, name: "causeOfLeaks")
  List<DropdownItem> causeOfLeaks;

  @JsonKey(nullable: true, name: "accountStatuses")
  List<DropdownItem> accountStatuses;

  @JsonKey(nullable: true, name: "industryTypes")
  List<DropdownItem> industryTypes;

  @JsonKey(nullable: true, name: "temperatureClasses")
  List<DropdownItem> temperatureClasses;

  @JsonKey(nullable: true, name: "chargeCapacitySourceTypes")
  List<DropdownItem> chargeCapacitySourceTypes;

  DropdownList({this.serviceActions, this.assetStatuses,
    this.coolingApplianceStatuses, this.assetTypes, this.assetSubtypes,
    this.workItemStatuses, this.workItemTypes, this.leakDetectionMethods,
    this.purposesForAddingGas, this.materialTypes, this.materialStatuses,
    this.leakRepairStatuses, this.leakLocationCategories, this.leakLocations,
    this.causeOfLeaks, this.accountStatuses, this.industryTypes,
    this.temperatureClasses, this.chargeCapacitySourceTypes});

  factory DropdownList.fromJson(Map<String, dynamic> json) =>
      _$DropdownListFromJson(json);
  Map<String, dynamic> toJson() => _$DropdownListToJson(this);
}

@JsonSerializable()
class DropdownItem {
  @JsonKey(nullable: true, name: "Name")
  String name;

  @JsonKey(nullable: true, name: "ID")
  int id;

  @override
  String toString() => '${this.name}';

  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is DropdownItem && other.id == id;

  DropdownItem({this.name, this.id});

  factory DropdownItem.fromJson(Map<String, dynamic> json) =>
      _$DropdownItemFromJson(json);
  Map<String, dynamic> toJson() => _$DropdownItemToJson(this);
}

@JsonSerializable()
class AssetTypeItem {
  @JsonKey(nullable: true, name: "Name")
  String name; // Name

  @JsonKey(nullable: true, name: "ID")
  int id;

  @JsonKey(nullable: true, name: "IsCylinder")
  bool isCylinder;

  @override
  String toString() => '${this.name}';

  AssetTypeItem({this.name, this.id, this.isCylinder});

  factory AssetTypeItem.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeItemFromJson(json);
  Map<String, dynamic> toJson() => _$AssetTypeItemToJson(this);
}

@JsonSerializable()
class LeakLocationItem {
  @JsonKey(nullable: true, name: "ID")
  int id;

  @JsonKey(nullable: true, name: "Name")
  String name;

  @JsonKey(nullable: true, name: "Category")
  String category;

  @JsonKey(nullable: true, name: "CategoryID")
  int categoryID;

  @override
  String toString() => '${this.name}';

  LeakLocationItem({this.id, this.name, this.category, this.categoryID});

  factory LeakLocationItem.fromJson(Map<String, dynamic> json) =>
      _$LeakLocationItemFromJson(json);
  Map<String, dynamic> toJson() => _$LeakLocationItemToJson(this);
}