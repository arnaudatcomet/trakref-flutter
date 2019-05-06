import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'workorder.g.dart';

@JsonSerializable()
class WorkOrder {
  @JsonKey(name: 'WorkOrderNumber', nullable: false)
  final String workOrderNumber;

  @JsonKey(name: 'WorkOrderStatusID', nullable: false)
  final int workOrderStatusID;

  @JsonKey(name: 'Address2')
  final String address2;

  @JsonKey(name: 'WorkOrderType')
  final String workOrderType;

  @JsonKey(name: 'TroubleTicketPriority')
  final String troubleTicketPriority;

  @JsonKey(name: 'WorkOrderStatusReasonID')
  final int workOrderStatusReasonID;

  @JsonKey(name: 'City')
  final String city;

  @JsonKey(name: 'WorkOrderTypeID', nullable: false)
  final int workOrderTypeID;

  @JsonKey(name: 'Location')
  final String location;

  @JsonKey(name: 'WorkItemCount')
  final int workItemCount;

  @JsonKey(name: 'State')
  final String state;

  @JsonKey(name: 'WorkOrderStatus')
  final String workOrderStatus;

  @JsonKey(name: 'Zipcode')
  final String zipcode;

  @JsonKey(name: 'CountryCode')
  final String countryCode;

  @JsonKey(name: 'Instance')
  final String instance;

  @JsonKey(name: 'ID', nullable: false)
  final int id;

  @JsonKey(name: 'ScheduleDate')
  final String scheduleDate;

  @JsonKey(name: 'DueDate')
  final String dueDate;

  @JsonKey(name: 'LocationID', nullable: false)
  final int locationID;

  @JsonKey(name: 'TroubleTicketPriorityID')
  final int troubleTicketPriorityID;

  @JsonKey(name: 'Address1')
  final String address1;

  @JsonKey(name: 'PurchaseOrderNumber')
  final String purchaseOrderNumber;

  @JsonKey(name: 'WorkOrderStatusReason')
  final String workOrderStatusReason;

  @JsonKey(name: 'InstanceID', nullable: false)
  final int instanceID;

  @JsonKey(nullable: true, name: 'WorkItem')
  List<WorkItem> workItem;

  @JsonKey(name: 'RequestDetails')
  final String requestDetails;

  WorkOrder({@required this.id, @required this.workOrderNumber, @required this.workOrderTypeID, @required this.workOrderStatusID, @required this.locationID, @required this.instanceID, this.address2,
    this.workOrderType, this.troubleTicketPriority,
    this.workOrderStatusReasonID, this.city,
    this.location, this.workItemCount, this.state, this.workOrderStatus,
    this.zipcode, this.countryCode, this.instance, this.scheduleDate,
    this.dueDate, this.troubleTicketPriorityID,
    this.address1, this.purchaseOrderNumber, this.workOrderStatusReason,
    this.requestDetails, List<WorkItem> workItem}): workItem = workItem ?? <WorkItem>[];

  factory WorkOrder.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderFromJson(json);
  Map<String, dynamic> toJson() => _$WorkOrderToJson(this);
}


@JsonSerializable(includeIfNull: false)
class WorkItem {
  @JsonKey(name: 'ChargeCapacitySourceTypeID')
  final int chargeCapacitySourceTypeID;

  @JsonKey(name: 'LeakRepairDispositionType')
  final String leakRepairDispositionType;

  @JsonKey(name: 'MaterialTypeID')
  final int materialTypeID;

  @JsonKey(name: 'WorkItemTypeID', nullable: false)
  final int workItemTypeID;

  @JsonKey(name: 'WasLeakFound')
  final bool wasLeakFound;

  @JsonKey(name: 'WorkItemType')
  final String workItemType;

  @JsonKey(name: 'ChargeCapacitySourceType')
  final String chargeCapacitySourceType;

  @JsonKey(name: 'WorkItemStatus')
  final String workItemStatus;

  @JsonKey(name: 'NetGasLbsAdded')
  final double netGasLbsAdded;

  @JsonKey(name: 'GasLbsAdded')
  final double gasLbsAdded;

  @JsonKey(name: 'VerificationLeakDetectionMethod')
  final String verificationLeakDetectionMethod;

  @JsonKey(name: 'MaterialTransferCount')
  final int materialTransferCount;

  @JsonKey(name: 'AssetLocationID')
  final int assetLocationID;

  @JsonKey(name: 'AssetID', nullable: false)
  final int assetID;

  @JsonKey(name: 'WorkItemStatusID', nullable: false)
  final int workItemStatusID;

  @JsonKey(name: 'Asset')
  final String asset;

  @JsonKey(name: 'InitialLeakDetectionMethod')
  final String initialLeakDetectionMethod;

  @JsonKey(name: 'VerificationLeakDetectionMethodID')
  final int verificationLeakDetectionMethodID;

  @JsonKey(name: 'CurrentGasWeightLbs')
  final double currentGasWeightLbs;

  @JsonKey(name: 'FinalCoolingApplianceStatusID')
  final int finalCoolingApplianceStatusID;

  @JsonKey(name: 'ServiceActionID')
  final int serviceActionID;

  @JsonKey(name: 'ServiceAction')
  final String serviceAction;

  @JsonKey(name: 'AssetLocation')
  final String assetLocation;

  @JsonKey(name: 'InitialLeakDetectionMethodID')
  final int initialLeakDetectionMethodID;

  @JsonKey(nullable: true, name: 'MaterialTransfer')
  List<MaterialTransfer> materialTransfer;

  @JsonKey(name: 'PartsRequired')
  final String partsRequired;

  @JsonKey(name: 'ServiceDate', nullable: false)
  final String serviceDate;

  @JsonKey(name: 'Notes')
  final String notes;

  @JsonKey(name: 'WasProblemResolved')
  final bool wasProblemResolved;

  @JsonKey(name: 'RepairNotes')
  final String repairNotes;

  @JsonKey(name: 'RepairTestResults')
  final String repairTestResults;

  @JsonKey(name: 'ServiceTransferReasonID')
  final int serviceTransferReasonID;

  @JsonKey(name: 'DateOfFollowUpService')
  final String dateOfFollowUpService;

  @JsonKey(name: 'LeakRepairDispositionTypeID')
  final int leakRepairDispositionTypeID;

  @JsonKey(name: 'DateLeakFound')
  final String dateLeakFound;

  @JsonKey(name: 'GasLbsRemoved')
  final double gasLbsRemoved;

  @JsonKey(name: 'VacuumPSI')
  final double vacuumPSI;

  @JsonKey(name: 'WasProperVacuumPulled')
  final bool wasProperVacuumPulled;

  @JsonKey(name: 'MaterialType')
  final String materialType;

  @JsonKey(name: 'FinalCoolingApplianceStatus')
  final String finalCoolingApplianceStatus;

  @JsonKey(name: 'LeakInspectionCount')
  final int leakInspectionCount;

  @JsonKey(name: 'ServiceTransferReason')
  final String serviceTransferReason;

  @JsonKey(name: 'WorkItemID')
  final int workItemID;

  @JsonKey(nullable: true, name: 'LeakInspection')
  List<LeakInspection> leakInspection;


  WorkItem({this.chargeCapacitySourceTypeID, this.leakRepairDispositionType,
    this.materialTypeID, @required this.workItemTypeID, this.wasLeakFound,
    this.workItemType, this.chargeCapacitySourceType, this.workItemStatus,
    this.netGasLbsAdded, this.gasLbsAdded,
    this.verificationLeakDetectionMethod, this.materialTransferCount,
    this.assetLocationID, @required this.assetID, @required this.workItemStatusID, this.asset,
    this.initialLeakDetectionMethod, this.verificationLeakDetectionMethodID,
    this.currentGasWeightLbs, this.finalCoolingApplianceStatusID,
    this.serviceActionID, this.serviceAction, this.assetLocation,
    this.initialLeakDetectionMethodID, this.partsRequired, @required this.serviceDate, this.notes, this.wasProblemResolved,
    this.repairNotes, this.repairTestResults, this.serviceTransferReasonID,
    this.dateOfFollowUpService, this.leakRepairDispositionTypeID,
    this.dateLeakFound, this.gasLbsRemoved, this.vacuumPSI,
    this.wasProperVacuumPulled, this.materialType,
    this.finalCoolingApplianceStatus, this.leakInspectionCount,
    this.serviceTransferReason, this.workItemID, List<MaterialTransfer> materialTransfer, List<LeakInspection> leakInspection}) : materialTransfer = materialTransfer ?? <MaterialTransfer>[], leakInspection = leakInspection ?? <LeakInspection>[];
  factory WorkItem.fromJson(Map<String, dynamic> json) => _$WorkItemFromJson(json);
  Map<String, dynamic> toJson() => _$WorkItemToJson(this);
}

@JsonSerializable()
class MaterialTransfer {
  @JsonKey(name: 'FromAssetID')
  final int fromAssetID;

  @JsonKey(name: 'ToLocationID')
  final int toLocationID;

  @JsonKey(name: 'ToAssetID')
  final int toAssetID;

  @JsonKey(name: 'ToAsset')
  final String toAsset;

  @JsonKey(name: 'TransferDate')
  final String transferDate;

  @JsonKey(name: 'Notes')
  final String notes;

  @JsonKey(name: 'FromAsset')
  final String fromAsset;

  @JsonKey(name: 'MaterialTypeID')
  final int materialTypeID;

  @JsonKey(name: 'TechnicianID')
  final int technicianID;

  @JsonKey(name: 'TechnicianName')
  final String technicianName;

  @JsonKey(name: 'ToLocation')
  final String toLocation;

  @JsonKey(name: 'CylinderNotes')
  final String cylinderNotes;

  @JsonKey(name: 'MaterialTransferType')
  final String materialTransferType;

  @JsonKey(name: 'TransferWeightLbs')
  final double transferWeightLbs;

  @JsonKey(name: 'MaterialTransferTypeID')
  final int materialTransferTypeID;

  @JsonKey(name: 'FromLocationID')
  final int fromLocationID;

  @JsonKey(name: 'MaterialTransferID')
  final int materialTransferID;

  @JsonKey(name: 'MaterialType')
  final String materialType;

  @JsonKey(name: 'FromLocation')
  final String fromLocation;

  MaterialTransfer({this.fromAssetID, this.toLocationID, this.toAssetID,
    this.toAsset, this.transferDate, this.notes, this.fromAsset,
    this.materialTypeID, this.technicianID, this.technicianName,
    this.toLocation, this.cylinderNotes, this.materialTransferType,
    this.transferWeightLbs, this.materialTransferTypeID, this.fromLocationID,
    this.materialTransferID, this.materialType, this.fromLocation});

  factory MaterialTransfer.fromJson(Map<String, dynamic> json) => _$MaterialTransferFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialTransferToJson(this);
}

@JsonSerializable()
class LeakInspection {
  @JsonKey(name: 'LeakDetectionMethod')
  final String leakDetectionMethod;

  @JsonKey(name: 'CoolingApplianceLeakInspectionID')
  final int coolingApplianceLeakInspectionID;

  @JsonKey(name: 'LeakInspectionType')
  final String leakInspectionType;

  @JsonKey(name: 'EstimatedLeakAmount')
  final double estimatedLeakAmount;

  @JsonKey(name: 'FaultCauseType')
  final String faultCauseType;

  @JsonKey(name: 'WasLeakFound', nullable: false)
  final bool wasLeakFound;

  @JsonKey(name: 'FaultCauseTypeID')
  final int faultCauseTypeID;

  @JsonKey(name: 'LeakLocationCategory')
  final String leakLocationCategory;

  @JsonKey(name: 'InspectionDate')
  final String inspectionDate;

  @JsonKey(name: 'LeakLocation')
  final String leakLocation;

  @JsonKey(name: 'LeakLocationCategoryID')
  final int leakLocationCategoryID;

  @JsonKey(name: 'Notes')
  final String notes;

  @JsonKey(name: 'LeakLocationID')
  final int leakLocationID;

  @JsonKey(name: 'LeakDetectionMethodID', nullable: false)
  final int leakDetectionMethodID;

  LeakInspection({this.leakDetectionMethod,
    this.coolingApplianceLeakInspectionID, this.leakInspectionType,
    this.estimatedLeakAmount, this.faultCauseType, @required this.wasLeakFound,
    this.faultCauseTypeID, this.leakLocationCategory, this.inspectionDate,
    this.leakLocation, this.leakLocationCategoryID, this.notes,
    this.leakLocationID, @required this.leakDetectionMethodID});

  factory LeakInspection.fromJson(Map<String, dynamic> json) =>
      _$LeakInspectionFromJson(json);
  Map<String, dynamic> toJson() => _$LeakInspectionToJson(this);
}