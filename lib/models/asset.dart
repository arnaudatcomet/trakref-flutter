import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:trakref_app/models/workorder.dart';

part 'asset.g.dart';

@JsonSerializable()
class Asset {
  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'AssetID')
  final int assetID;

  @JsonKey(name: 'AssetStatusID')
  final int assetStatusID;

  @JsonKey(name: 'AssetStatus')
  final String assetStatus;

  @JsonKey(name: 'IsCylinder')
  final bool isCylinder;

  @JsonKey(name: 'InstanceID')
  final int instanceID;

  @JsonKey(name: 'Instance')
  final String instance;

  @JsonKey(name: 'LocationID')
  final int locationID;

  @JsonKey(name: 'Location')
  final String location;

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

  @JsonKey(name: 'SerialNumber')
  final String serialNumber;

  @JsonKey(name: 'TagNumber')
  final String tagNumber;

  @JsonKey(name: 'MaterialTypeID')
  final int materialTypeID;

  @JsonKey(name: 'MaterialType')
  final String materialType;

  @JsonKey(name: 'CurrentGasWeightLbs')
  final double currentGasWeightLbs;

  @JsonKey(name: 'MaxGasCapacityLbs')
  final double maxGasCapacityLbs;

  @JsonKey(name: 'Category')
  final String category;

  @JsonKey(name: 'AssetCategoryID')
  final int assetCategoryID;

  @JsonKey(name: 'AssetCategory')
  final String assetCategory;

  @JsonKey(name: 'AssetTypeID')
  final int assetTypeID;

  @JsonKey(name: 'AssetType')
  final String assetType;

  @JsonKey(name: 'AssetSubtypeID')
  final int assetSubtypeID;

  @JsonKey(name: 'AssetSubtype')
  final String assetSubtype;

  @JsonKey(name: 'AssetKindID')
  final int assetKindID;

  @JsonKey(name: 'AssetKind')
  final String assetKind;

  @JsonKey(name: 'PONumber')
  final String poNumber;

  @JsonKey(name: 'LeakRate')
  final double leakRate;

  @JsonKey(name: 'LastServiceDate')
  final String lastServiceDate;

  @JsonKey(name: 'WorkItemCount')
  final int workItemCount;

  @JsonKey(nullable: true, name: 'WorkItem')
  List<WorkItem> workItem;

  @JsonKey(name: 'ID')
  final int id;

  @JsonKey(name: 'WeightUnits')
  final String weightUnits;


  Asset({this.name, this.assetID, this.assetStatusID, this.assetStatus,
    this.isCylinder, this.instanceID, this.instance, this.locationID,
    this.location, this.address1, this.address2, this.city, this.state,
    this.zipcode, this.country, this.serialNumber, this.tagNumber,
    this.materialTypeID, this.materialType, this.currentGasWeightLbs,
    this.maxGasCapacityLbs, this.category, this.assetCategoryID,
    this.assetCategory, this.assetTypeID, this.assetType, this.assetSubtypeID,
    this.assetSubtype, this.assetKindID, this.assetKind, this.poNumber,
    this.leakRate, this.lastServiceDate, this.workItemCount, this.id, this.weightUnits, List<WorkItem> workItem}): workItem = workItem ?? <WorkItem>[];

  factory Asset.fromJson(Map<String, dynamic> json) =>
      _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);

  int get hashCode => assetID.hashCode;

  @override
  bool operator ==(Object other) => other is Asset && other.assetID == assetID;
}