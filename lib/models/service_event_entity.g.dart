// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrder _$WorkOrderFromJson(Map<String, dynamic> json) {
  return WorkOrder(
      workOrderNumber: json['WorkOrderNumber'] as String,
      workOrderStatusID: json['WorkOrderStatusID'] as int,
      address2: json['Address2'] as String,
      workOrderType: json['WorkOrderType'] as String,
      troubleTicketPriority: json['TroubleTicketPriority'] as String,
      workOrderStatusReasonID: json['WorkOrderStatusReasonID'] as int,
      city: json['City'] as String,
      workOrderTypeID: json['WorkOrderTypeID'] as int,
      location: json['Location'] as String,
      workItemCount: json['WorkItemCount'] as int,
      state: json['State'] as String,
      workOrderStatus: json['WorkOrderStatus'] as String,
      zipCode: json['Zipcode'] as String,
      countryCode: json['CountryCode'] as String,
      instance: json['Instance'] as String,
      id: json['ID'] as int,
      scheduleDate: json['ScheduleDate'] as String,
      dueDate: json['DueDate'] as String,
      locationID: json['LocationID'] as int,
      troubleTicketPriorityID: json['TroubleTicketPriorityID'] as int,
      address1: json['Address1'] as String,
      purchaseOrderNumber: json['PurchaseOrderNumber'] as String,
      workOrderStatusReason: json['WorkOrderStatusReason'] as String,
      instanceID: json['InstanceID'] as int,
      requestDetails: json['RequestDetails'] as String,
      workItems: (json['WorkItem'] as List)
          .map((e) => WorkItem.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$WorkOrderToJson(WorkOrder instance) => <String, dynamic>{
      'WorkOrderNumber': instance.workOrderNumber,
      'WorkOrderStatusID': instance.workOrderStatusID,
      'Address2': instance.address2,
      'WorkOrderType': instance.workOrderType,
      'TroubleTicketPriority': instance.troubleTicketPriority,
      'WorkOrderStatusReasonID': instance.workOrderStatusReasonID,
      'City': instance.city,
      'WorkOrderTypeID': instance.workOrderTypeID,
      'Location': instance.location,
      'WorkItemCount': instance.workItemCount,
      'State': instance.state,
      'WorkOrderStatus': instance.workOrderStatus,
      'Zipcode': instance.zipCode,
      'CountryCode': instance.countryCode,
      'Instance': instance.instance,
      'ID': instance.id,
      'ScheduleDate': instance.scheduleDate,
      'DueDate': instance.dueDate,
      'LocationID': instance.locationID,
      'TroubleTicketPriorityID': instance.troubleTicketPriorityID,
      'Address1': instance.address1,
      'PurchaseOrderNumber': instance.purchaseOrderNumber,
      'WorkOrderStatusReason': instance.workOrderStatusReason,
      'InstanceID': instance.instanceID,
      'WorkItem': instance.workItems,
      'RequestDetails': instance.requestDetails
    };

WorkItem _$WorkItemFromJson(Map<String, dynamic> json) {
  return WorkItem(
      json['ChargeCapacitySourceTypeID'] as int,
      json['LeakRepairDispositionType'] as String,
      json['MaterialTypeID'] as int,
      json['WorkItemTypeID'] as int,
      json['WasLeakFound'] as bool,
      json['WorkItemType'] as String,
      json['ChargeCapacitySourceType'] as String,
      json['WorkItemStatus'] as String,
      (json['NetGasLbsAdded'] as num).toDouble(),
      json['GasLbsAdded'] as int,
      json['VerificationLeakDetectionMethod'] as String,
      json['MaterialTransferCount'] as int,
      json['AssetLocationID'] as int,
      json['AssetID'] as int,
      json['WorkItemStatusID'] as int,
      json['Asset'] as String,
      json['InitialLeakDetectionMethod'] as String,
      json['VerificationLeakDetectionMethodID'] as int,
      (json['CurrentGasWeightLbs'] as num).toDouble(),
      json['FinalCoolingApplianceStatusID'] as int,
      json['ServiceActionID'] as int,
      json['ServiceAction'] as String,
      json['AssetLocation'] as String,
      json['InitialLeakDetectionMethodID'] as int,
      json['PartsRequired'] as String,
      json['ServiceDate'] as String,
      json['Notes'] as String,
      json['WasProblemResolved'] as bool,
      json['RepairNotes'] as String,
      json['RepairTestResults'] as String,
      json['ServiceTransferReasonID'] as int,
      json['DateOfFollowUpService'] as String,
      json['LeakRepairDispositionTypeID'] as int,
      json['DateLeakFound'] as String,
      json['GasLbsRemoved'] as int,
      (json['VacuumPSI'] as num).toDouble(),
      json['WasProperVacuumPulled'] as bool,
      json['MaterialType'] as String,
      json['FinalCoolingApplianceStatus'] as int,
      json['LeakInspectionCount'] as int,
      json['ServiceTransferReason'] as String,
      json['WorkItemID'] as int)
    ..leakInspection = (json['LeakInspection'] as List)
        .map((e) => LeakInspection.fromJson(e as Map<String, dynamic>))
        .toList()
    ..materialTransfer = (json['MaterialTransfer'] as List)
        .map((e) => MaterialTransfer.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$WorkItemToJson(WorkItem instance) => <String, dynamic>{
      'ChargeCapacitySourceTypeID': instance.chargeCapacitySourceTypeID,
      'LeakRepairDispositionType': instance.leakRepairDispositionType,
      'MaterialTypeID': instance.materialTypeID,
      'WorkItemTypeID': instance.workItemTypeID,
      'WasLeakFound': instance.wasLeakFound,
      'WorkItemType': instance.workItemType,
      'ChargeCapacitySourceType': instance.chargeCapacitySourceType,
      'WorkItemStatus': instance.workItemStatus,
      'NetGasLbsAdded': instance.netGasLbsAdded,
      'GasLbsAdded': instance.gasLbsAdded,
      'VerificationLeakDetectionMethod':
          instance.verificationLeakDetectionMethod,
      'LeakInspection': instance.leakInspection,
      'MaterialTransferCount': instance.materialTransferCount,
      'AssetLocationID': instance.assetLocationID,
      'AssetID': instance.assetID,
      'WorkItemStatusID': instance.workItemStatusID,
      'Asset': instance.asset,
      'InitialLeakDetectionMethod': instance.initialLeakDetectionMethod,
      'VerificationLeakDetectionMethodID':
          instance.verificationLeakDetectionMethodID,
      'CurrentGasWeightLbs': instance.currentGasWeightLbs,
      'FinalCoolingApplianceStatusID': instance.finalCoolingApplianceStatusID,
      'ServiceActionID': instance.serviceActionID,
      'ServiceAction': instance.serviceAction,
      'AssetLocation': instance.assetLocation,
      'InitialLeakDetectionMethodID': instance.initialLeakDetectionMethodID,
      'MaterialTransfer': instance.materialTransfer,
      'PartsRequired': instance.partsRequired,
      'ServiceDate': instance.serviceDate,
      'Notes': instance.notes,
      'WasProblemResolved': instance.wasProblemResolved,
      'RepairNotes': instance.repairNotes,
      'RepairTestResults': instance.repairTestResults,
      'ServiceTransferReasonID': instance.serviceTransferReasonID,
      'DateOfFollowUpService': instance.dateOfFollowUpService,
      'LeakRepairDispositionTypeID': instance.leakRepairDispositionTypeID,
      'DateLeakFound': instance.dateLeakFound,
      'GasLbsRemoved': instance.gasLbsRemoved,
      'VacuumPSI': instance.vacuumPSI,
      'WasProperVacuumPulled': instance.wasProperVacuumPulled,
      'MaterialType': instance.materialType,
      'FinalCoolingApplianceStatus': instance.finalCoolingApplianceStatus,
      'LeakInspectionCount': instance.leakInspectionCount,
      'ServiceTransferReason': instance.serviceTransferReason,
      'WorkItemID': instance.workItemID
    };

LeakInspection _$LeakInspectionFromJson(Map<String, dynamic> json) {
  return LeakInspection(
      leakDetectionMethod: json['LeakDetectionMethod'] as String,
      coolingApplianceLeakInspectionID:
          json['CoolingApplianceLeakInspectionID'] as int,
      leakInspectionType: json['LeakInspectionType'] as String,
      estimatedLeakAmount: json['EstimatedLeakAmount'] as int,
      faultCauseType: json['FaultCauseType'] as String,
      wasLeakFound: json['WasLeakFound'] as bool,
      faultCauseTypeID: json['FaultCauseTypeID'] as int,
      leakLocationCategory: json['LeakLocationCategory'] as String,
      inspectionDate: json['InspectionDate'] as String,
      leakLocation: json['LeakLocation'] as String,
      leakLocationCategoryID: json['LeakLocationCategoryID'] as int,
      notes: json['Notes'] as String,
      leakLocationID: json['LeakLocationID'] as int,
      leakDetectionMethodID: json['LeakDetectionMethodID'] as int);
}

Map<String, dynamic> _$LeakInspectionToJson(LeakInspection instance) =>
    <String, dynamic>{
      'LeakDetectionMethod': instance.leakDetectionMethod,
      'CoolingApplianceLeakInspectionID':
          instance.coolingApplianceLeakInspectionID,
      'LeakInspectionType': instance.leakInspectionType,
      'EstimatedLeakAmount': instance.estimatedLeakAmount,
      'FaultCauseType': instance.faultCauseType,
      'WasLeakFound': instance.wasLeakFound,
      'FaultCauseTypeID': instance.faultCauseTypeID,
      'LeakLocationCategory': instance.leakLocationCategory,
      'InspectionDate': instance.inspectionDate,
      'LeakLocation': instance.leakLocation,
      'LeakLocationCategoryID': instance.leakLocationCategoryID,
      'Notes': instance.notes,
      'LeakLocationID': instance.leakLocationID,
      'LeakDetectionMethodID': instance.leakDetectionMethodID
    };

MaterialTransfer _$MaterialTransferFromJson(Map<String, dynamic> json) {
  return MaterialTransfer(
      json['FromAssetID'] as int,
      json['ToLocationID'] as int,
      json['ToAssetID'] as int,
      json['ToAsset'] as String,
      json['TransferDate'] as String,
      json['Notes'] as String,
      json['FromAsset'] as String,
      json['MaterialTypeID'] as int,
      json['TechnicianID'] as int,
      json['TechnicianName'] as String,
      json['ToLocation'] as String,
      json['CylinderNotes'] as String,
      json['MaterialTransferType'] as String,
      json['TransferWeightLbs'] as int,
      json['MaterialTransferTypeID'] as int,
      json['FromLocationID'] as int,
      json['MaterialTransferID'] as int,
      json['MaterialType'] as String,
      json['FromLocation'] as String);
}

Map<String, dynamic> _$MaterialTransferToJson(MaterialTransfer instance) =>
    <String, dynamic>{
      'FromAssetID': instance.fromAssetID,
      'ToLocationID': instance.toLocationID,
      'ToAssetID': instance.toAssetID,
      'ToAsset': instance.toAsset,
      'TransferDate': instance.transferDate,
      'Notes': instance.notes,
      'FromAsset': instance.fromAsset,
      'MaterialTypeID': instance.materialTypeID,
      'TechnicianID': instance.technicianID,
      'TechnicianName': instance.technicianName,
      'ToLocation': instance.toLocation,
      'CylinderNotes': instance.cylinderNotes,
      'MaterialTransferType': instance.materialTransferType,
      'TransferWeightLbs': instance.transferWeightLbs,
      'MaterialTransferTypeID': instance.materialTransferTypeID,
      'FromLocationID': instance.fromLocationID,
      'MaterialTransferID': instance.materialTransferID,
      'MaterialType': instance.materialType,
      'FromLocation': instance.fromLocation
    };
