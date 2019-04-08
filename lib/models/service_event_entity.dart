import 'package:json_annotation/json_annotation.dart';

part 'service_event_entity.g.dart';

@JsonSerializable(nullable: false)
class WorkOrder {
  @JsonKey(name: 'WorkOrderNumber')
  String workOrderNumber;

  @JsonKey(name: 'WorkOrderStatusID')
  int workOrderStatusID;

  @JsonKey(name: 'Address2')
  String address2;

  @JsonKey(name: 'WorkOrderType')
  String workOrderType;

  @JsonKey(name: 'TroubleTicketPriority')
  String troubleTicketPriority;

  @JsonKey(name: 'WorkOrderStatusReasonID')
  int workOrderStatusReasonID;

  @JsonKey(name: 'City')
  String city;

  @JsonKey(name: 'WorkOrderTypeID')
  int workOrderTypeID;

  @JsonKey(name: 'Location')
  String location;

  @JsonKey(name: 'WorkItemCount')
  int workItemCount;

  @JsonKey(name: 'State')
  String state;

  @JsonKey(name: 'WorkOrderStatus')
  String workOrderStatus;

  @JsonKey(name: 'Zipcode')
  String zipCode;

  @JsonKey(name: 'CountryCode')
  String countryCode;

  @JsonKey(name: 'Instance')
  String instance;

  @JsonKey(name: 'ID')
  int id;

  @JsonKey(name: 'ScheduleDate')
  String scheduleDate;

  @JsonKey(name: 'DueDate')
  String dueDate;

  @JsonKey(name: 'LocationID')
  int locationID;

  @JsonKey(name: 'TroubleTicketPriorityID')
  int troubleTicketPriorityID;

  @JsonKey(name: 'Address1')
  String address1;

  @JsonKey(name: 'PurchaseOrderNumber')
  String purchaseOrderNumber;

  @JsonKey(name: 'WorkOrderStatusReason')
  String workOrderStatusReason;

  @JsonKey(name: 'InstanceID')
  int instanceID;

  @JsonKey(name: 'WorkItem')
  List<WorkItem> workItems;

  @JsonKey(name: 'RequestDetails')
  String requestDetails;

  WorkOrder({this.workOrderNumber, this.workOrderStatusID, this.address2,
    this.workOrderType, this.troubleTicketPriority,
    this.workOrderStatusReasonID, this.city, this.workOrderTypeID,
    this.location, this.workItemCount, this.state, this.workOrderStatus,
    this.zipCode, this.countryCode, this.instance, this.id, this.scheduleDate,
    this.dueDate, this.locationID, this.troubleTicketPriorityID,
    this.address1, this.purchaseOrderNumber, this.workOrderStatusReason,
    this.instanceID, this.requestDetails, this.workItems});

  factory WorkOrder.fromJson(Map<String, dynamic> json) => _$WorkOrderToJson(json);
  Map<String, dynamic> toJson() => _$WorkOrderToJson(this);
}

@JsonSerializable(nullable: false)
class WorkItem {
  @JsonKey(name: 'ChargeCapacitySourceTypeID')
  int chargeCapacitySourceTypeID;

  @JsonKey(name: 'LeakRepairDispositionType')
  String leakRepairDispositionType;

  @JsonKey(name: 'MaterialTypeID')
  int materialTypeID;

  @JsonKey(name: 'WorkItemTypeID')
  int workItemTypeID;

  @JsonKey(name: 'WasLeakFound')
  bool wasLeakFound;

  @JsonKey(name: 'WorkItemType')
  String workItemType;

  @JsonKey(name: 'ChargeCapacitySourceType')
  String chargeCapacitySourceType;

  @JsonKey(name: 'WorkItemStatus')
  String workItemStatus;

  @JsonKey(name: 'NetGasLbsAdded')
  double netGasLbsAdded;

  @JsonKey(name: 'GasLbsAdded')
  int gasLbsAdded;

  @JsonKey(name: 'VerificationLeakDetectionMethod')
  String verificationLeakDetectionMethod;

  @JsonKey(name: 'LeakInspection')
  List<LeakInspection> leakInspection;

  @JsonKey(name: 'MaterialTransferCount')
  int materialTransferCount;

  @JsonKey(name: 'AssetLocationID')
  int assetLocationID;

  @JsonKey(name: 'AssetID')
  int assetID;

  @JsonKey(name: 'WorkItemStatusID')
  int workItemStatusID;

  @JsonKey(name: 'Asset')
  String asset;

  @JsonKey(name: 'InitialLeakDetectionMethod')
  String initialLeakDetectionMethod;

  @JsonKey(name: 'VerificationLeakDetectionMethodID')
  int verificationLeakDetectionMethodID;

  @JsonKey(name: 'CurrentGasWeightLbs')
  double currentGasWeightLbs;

  @JsonKey(name: 'FinalCoolingApplianceStatusID')
  int finalCoolingApplianceStatusID;

  @JsonKey(name: 'ServiceActionID')
  int serviceActionID;

  @JsonKey(name: 'ServiceAction')
  String serviceAction;

  @JsonKey(name: 'AssetLocation')
  String assetLocation;

  @JsonKey(name: 'InitialLeakDetectionMethodID')
  int initialLeakDetectionMethodID;

  @JsonKey(name: 'MaterialTransfer')
  List<MaterialTransfer> materialTransfer;

  @JsonKey(name: 'PartsRequired')
  String partsRequired;

  @JsonKey(name: 'ServiceDate')
  String serviceDate;

  @JsonKey(name: 'Notes')
  String notes;

  @JsonKey(name: 'WasProblemResolved')
  bool wasProblemResolved;

  @JsonKey(name: 'RepairNotes')
  String repairNotes;

  @JsonKey(name: 'RepairTestResults')
  String repairTestResults;

  @JsonKey(name: 'ServiceTransferReasonID')
  int serviceTransferReasonID;

  @JsonKey(name: 'DateOfFollowUpService')
  String dateOfFollowUpService;

  @JsonKey(name: 'LeakRepairDispositionTypeID')
  int leakRepairDispositionTypeID;

  @JsonKey(name: 'DateLeakFound')
  String dateLeakFound;

  @JsonKey(name: 'GasLbsRemoved')
  int gasLbsRemoved;

  @JsonKey(name: 'VacuumPSI')
  double vacuumPSI;

  @JsonKey(name: 'WasProperVacuumPulled')
  bool wasProperVacuumPulled;

  @JsonKey(name: 'MaterialType')
  String materialType;

  @JsonKey(name: 'FinalCoolingApplianceStatus')
  int finalCoolingApplianceStatus;

  @JsonKey(name: 'LeakInspectionCount')
  int leakInspectionCount;

  @JsonKey(name: 'ServiceTransferReason')
  String serviceTransferReason;

  @JsonKey(name: 'WorkItemID')
  int workItemID;

  WorkItem(this.chargeCapacitySourceTypeID, this.leakRepairDispositionType,
      this.materialTypeID, this.workItemTypeID, this.wasLeakFound,
      this.workItemType, this.chargeCapacitySourceType, this.workItemStatus,
      this.netGasLbsAdded, this.gasLbsAdded,
      this.verificationLeakDetectionMethod, this.materialTransferCount,
      this.assetLocationID, this.assetID, this.workItemStatusID, this.asset,
      this.initialLeakDetectionMethod, this.verificationLeakDetectionMethodID,
      this.currentGasWeightLbs, this.finalCoolingApplianceStatusID,
      this.serviceActionID, this.serviceAction, this.assetLocation,
      this.initialLeakDetectionMethodID, this.partsRequired, this.serviceDate,
      this.notes, this.wasProblemResolved, this.repairNotes,
      this.repairTestResults, this.serviceTransferReasonID,
      this.dateOfFollowUpService, this.leakRepairDispositionTypeID,
      this.dateLeakFound, this.gasLbsRemoved, this.vacuumPSI,
      this.wasProperVacuumPulled, this.materialType,
      this.finalCoolingApplianceStatus, this.leakInspectionCount,
      this.serviceTransferReason, this.workItemID);

  factory WorkItem.fromJson(Map<String, dynamic> json) => _$WorkItemToJson(json);
  Map<String, dynamic> toJson() => _$WorkItemToJson(this);
}

@JsonSerializable(nullable: false)
class LeakInspection {
  @JsonKey(name: 'LeakDetectionMethod')
  String leakDetectionMethod;

  @JsonKey(name: 'CoolingApplianceLeakInspectionID')
  int coolingApplianceLeakInspectionID;

  @JsonKey(name: 'LeakInspectionType')
  String leakInspectionType;

  @JsonKey(name: 'EstimatedLeakAmount')
  int estimatedLeakAmount;

  @JsonKey(name: 'FaultCauseType')
  String faultCauseType;

  @JsonKey(name: 'WasLeakFound')
  bool wasLeakFound;

  @JsonKey(name: 'FaultCauseTypeID')
  int faultCauseTypeID;

  @JsonKey(name: 'LeakLocationCategory')
  String leakLocationCategory;

  @JsonKey(name: 'InspectionDate')
  String inspectionDate;

  @JsonKey(name: 'LeakLocation')
  String leakLocation;

  @JsonKey(name: 'LeakLocationCategoryID')
  int leakLocationCategoryID;

  @JsonKey(name: 'Notes')
  String notes;

  @JsonKey(name: 'LeakLocationID')
  int leakLocationID;

  @JsonKey(name: 'LeakDetectionMethodID')
  int leakDetectionMethodID;

  LeakInspection({this.leakDetectionMethod,
    this.coolingApplianceLeakInspectionID, this.leakInspectionType,
    this.estimatedLeakAmount, this.faultCauseType, this.wasLeakFound,
    this.faultCauseTypeID, this.leakLocationCategory, this.inspectionDate,
    this.leakLocation, this.leakLocationCategoryID, this.notes,
    this.leakLocationID, this.leakDetectionMethodID});

  factory LeakInspection.fromJson(Map<String, dynamic> json) => _$LeakInspectionToJson(json);
  Map<String, dynamic> toJson() => _$LeakInspectionToJson(this);
}

@JsonSerializable(nullable: false)
class MaterialTransfer {
  @JsonKey(name: 'FromAssetID')
  int fromAssetID;

  @JsonKey(name: 'ToLocationID')
  int toLocationID;

  @JsonKey(name: 'ToAssetID')
  int toAssetID;

  @JsonKey(name: 'ToAsset')
  String toAsset;

  @JsonKey(name: 'TransferDate')
  String transferDate;

  @JsonKey(name: 'Notes')
  String notes;

  @JsonKey(name: 'FromAsset')
  String fromAsset;

  @JsonKey(name: 'MaterialTypeID')
  int materialTypeID;

  @JsonKey(name: 'TechnicianID')
  int technicianID;

  @JsonKey(name: 'TechnicianName')
  String technicianName;

  @JsonKey(name: 'ToLocation')
  String toLocation;

  @JsonKey(name: 'CylinderNotes')
  String cylinderNotes;

  @JsonKey(name: 'MaterialTransferType')
  String materialTransferType;

  @JsonKey(name: 'TransferWeightLbs')
  int transferWeightLbs;

  @JsonKey(name: 'MaterialTransferTypeID')
  int materialTransferTypeID;

  @JsonKey(name: 'FromLocationID')
  int fromLocationID;

  @JsonKey(name: 'MaterialTransferID')
  int materialTransferID;

  @JsonKey(name: 'MaterialType')
  String materialType;

  @JsonKey(name: 'FromLocation')
  String fromLocation;


  MaterialTransfer(this.fromAssetID, this.toLocationID, this.toAssetID,
      this.toAsset, this.transferDate, this.notes, this.fromAsset,
      this.materialTypeID, this.technicianID, this.technicianName,
      this.toLocation, this.cylinderNotes, this.materialTransferType,
      this.transferWeightLbs, this.materialTransferTypeID, this.fromLocationID,
      this.materialTransferID, this.materialType, this.fromLocation);

  factory MaterialTransfer.fromJson(Map<String, dynamic> json) => _$MaterialTransferToJson(json);
  Map<String, dynamic> toJson() => _$MaterialTransferToJson(this);
}