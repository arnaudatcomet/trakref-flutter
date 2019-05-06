// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrder _$WorkOrderFromJson(Map<String, dynamic> json) {
  return WorkOrder(
      id: json['ID'] as int,
      workOrderNumber: json['WorkOrderNumber'] as String,
      workOrderTypeID: json['WorkOrderTypeID'] as int,
      workOrderStatusID: json['WorkOrderStatusID'] as int,
      locationID: json['LocationID'] as int,
      instanceID: json['InstanceID'] as int,
      address2: json['Address2'] as String,
      workOrderType: json['WorkOrderType'] as String,
      troubleTicketPriority: json['TroubleTicketPriority'] as String,
      workOrderStatusReasonID: json['WorkOrderStatusReasonID'] as int,
      city: json['City'] as String,
      location: json['Location'] as String,
      workItemCount: json['WorkItemCount'] as int,
      state: json['State'] as String,
      workOrderStatus: json['WorkOrderStatus'] as String,
      zipcode: json['Zipcode'] as String,
      countryCode: json['CountryCode'] as String,
      instance: json['Instance'] as String,
      scheduleDate: json['ScheduleDate'] as String,
      dueDate: json['DueDate'] as String,
      troubleTicketPriorityID: json['TroubleTicketPriorityID'] as int,
      address1: json['Address1'] as String,
      purchaseOrderNumber: json['PurchaseOrderNumber'] as String,
      workOrderStatusReason: json['WorkOrderStatusReason'] as String,
      requestDetails: json['RequestDetails'] as String,
      workItem: (json['WorkItem'] as List)
          ?.map((e) =>
              e == null ? null : WorkItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
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
      'Zipcode': instance.zipcode,
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
      'WorkItem': instance.workItem,
      'RequestDetails': instance.requestDetails
    };

WorkItem _$WorkItemFromJson(Map<String, dynamic> json) {
  return WorkItem(
      chargeCapacitySourceTypeID: json['ChargeCapacitySourceTypeID'] as int,
      leakRepairDispositionType: json['LeakRepairDispositionType'] as String,
      materialTypeID: json['MaterialTypeID'] as int,
      workItemTypeID: json['WorkItemTypeID'] as int,
      wasLeakFound: json['WasLeakFound'] as bool,
      workItemType: json['WorkItemType'] as String,
      chargeCapacitySourceType: json['ChargeCapacitySourceType'] as String,
      workItemStatus: json['WorkItemStatus'] as String,
      netGasLbsAdded: (json['NetGasLbsAdded'] as num)?.toDouble(),
      gasLbsAdded: (json['GasLbsAdded'] as num)?.toDouble(),
      verificationLeakDetectionMethod:
          json['VerificationLeakDetectionMethod'] as String,
      materialTransferCount: json['MaterialTransferCount'] as int,
      assetLocationID: json['AssetLocationID'] as int,
      assetID: json['AssetID'] as int,
      workItemStatusID: json['WorkItemStatusID'] as int,
      asset: json['Asset'] as String,
      initialLeakDetectionMethod: json['InitialLeakDetectionMethod'] as String,
      verificationLeakDetectionMethodID:
          json['VerificationLeakDetectionMethodID'] as int,
      currentGasWeightLbs: (json['CurrentGasWeightLbs'] as num)?.toDouble(),
      finalCoolingApplianceStatusID:
          json['FinalCoolingApplianceStatusID'] as int,
      serviceActionID: json['ServiceActionID'] as int,
      serviceAction: json['ServiceAction'] as String,
      assetLocation: json['AssetLocation'] as String,
      initialLeakDetectionMethodID: json['InitialLeakDetectionMethodID'] as int,
      partsRequired: json['PartsRequired'] as String,
      serviceDate: json['ServiceDate'] as String,
      notes: json['Notes'] as String,
      wasProblemResolved: json['WasProblemResolved'] as bool,
      repairNotes: json['RepairNotes'] as String,
      repairTestResults: json['RepairTestResults'] as String,
      serviceTransferReasonID: json['ServiceTransferReasonID'] as int,
      dateOfFollowUpService: json['DateOfFollowUpService'] as String,
      leakRepairDispositionTypeID: json['LeakRepairDispositionTypeID'] as int,
      dateLeakFound: json['DateLeakFound'] as String,
      gasLbsRemoved: (json['GasLbsRemoved'] as num)?.toDouble(),
      vacuumPSI: (json['VacuumPSI'] as num)?.toDouble(),
      wasProperVacuumPulled: json['WasProperVacuumPulled'] as bool,
      materialType: json['MaterialType'] as String,
      finalCoolingApplianceStatus:
          json['FinalCoolingApplianceStatus'] as String,
      leakInspectionCount: json['LeakInspectionCount'] as int,
      serviceTransferReason: json['ServiceTransferReason'] as String,
      workItemID: json['WorkItemID'] as int,
      materialTransfer: (json['MaterialTransfer'] as List)
          ?.map((e) => e == null
              ? null
              : MaterialTransfer.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      leakInspection: (json['LeakInspection'] as List)
          ?.map((e) => e == null
              ? null
              : LeakInspection.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$WorkItemToJson(WorkItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'ChargeCapacitySourceTypeID', instance.chargeCapacitySourceTypeID);
  writeNotNull('LeakRepairDispositionType', instance.leakRepairDispositionType);
  writeNotNull('MaterialTypeID', instance.materialTypeID);
  val['WorkItemTypeID'] = instance.workItemTypeID;
  writeNotNull('WasLeakFound', instance.wasLeakFound);
  writeNotNull('WorkItemType', instance.workItemType);
  writeNotNull('ChargeCapacitySourceType', instance.chargeCapacitySourceType);
  writeNotNull('WorkItemStatus', instance.workItemStatus);
  writeNotNull('NetGasLbsAdded', instance.netGasLbsAdded);
  writeNotNull('GasLbsAdded', instance.gasLbsAdded);
  writeNotNull('VerificationLeakDetectionMethod',
      instance.verificationLeakDetectionMethod);
  writeNotNull('MaterialTransferCount', instance.materialTransferCount);
  writeNotNull('AssetLocationID', instance.assetLocationID);
  val['AssetID'] = instance.assetID;
  val['WorkItemStatusID'] = instance.workItemStatusID;
  writeNotNull('Asset', instance.asset);
  writeNotNull(
      'InitialLeakDetectionMethod', instance.initialLeakDetectionMethod);
  writeNotNull('VerificationLeakDetectionMethodID',
      instance.verificationLeakDetectionMethodID);
  writeNotNull('CurrentGasWeightLbs', instance.currentGasWeightLbs);
  writeNotNull(
      'FinalCoolingApplianceStatusID', instance.finalCoolingApplianceStatusID);
  writeNotNull('ServiceActionID', instance.serviceActionID);
  writeNotNull('ServiceAction', instance.serviceAction);
  writeNotNull('AssetLocation', instance.assetLocation);
  writeNotNull(
      'InitialLeakDetectionMethodID', instance.initialLeakDetectionMethodID);
  writeNotNull('MaterialTransfer', instance.materialTransfer);
  writeNotNull('PartsRequired', instance.partsRequired);
  val['ServiceDate'] = instance.serviceDate;
  writeNotNull('Notes', instance.notes);
  writeNotNull('WasProblemResolved', instance.wasProblemResolved);
  writeNotNull('RepairNotes', instance.repairNotes);
  writeNotNull('RepairTestResults', instance.repairTestResults);
  writeNotNull('ServiceTransferReasonID', instance.serviceTransferReasonID);
  writeNotNull('DateOfFollowUpService', instance.dateOfFollowUpService);
  writeNotNull(
      'LeakRepairDispositionTypeID', instance.leakRepairDispositionTypeID);
  writeNotNull('DateLeakFound', instance.dateLeakFound);
  writeNotNull('GasLbsRemoved', instance.gasLbsRemoved);
  writeNotNull('VacuumPSI', instance.vacuumPSI);
  writeNotNull('WasProperVacuumPulled', instance.wasProperVacuumPulled);
  writeNotNull('MaterialType', instance.materialType);
  writeNotNull(
      'FinalCoolingApplianceStatus', instance.finalCoolingApplianceStatus);
  writeNotNull('LeakInspectionCount', instance.leakInspectionCount);
  writeNotNull('ServiceTransferReason', instance.serviceTransferReason);
  writeNotNull('WorkItemID', instance.workItemID);
  writeNotNull('LeakInspection', instance.leakInspection);
  return val;
}

MaterialTransfer _$MaterialTransferFromJson(Map<String, dynamic> json) {
  return MaterialTransfer(
      fromAssetID: json['FromAssetID'] as int,
      toLocationID: json['ToLocationID'] as int,
      toAssetID: json['ToAssetID'] as int,
      toAsset: json['ToAsset'] as String,
      transferDate: json['TransferDate'] as String,
      notes: json['Notes'] as String,
      fromAsset: json['FromAsset'] as String,
      materialTypeID: json['MaterialTypeID'] as int,
      technicianID: json['TechnicianID'] as int,
      technicianName: json['TechnicianName'] as String,
      toLocation: json['ToLocation'] as String,
      cylinderNotes: json['CylinderNotes'] as String,
      materialTransferType: json['MaterialTransferType'] as String,
      transferWeightLbs: (json['TransferWeightLbs'] as num)?.toDouble(),
      materialTransferTypeID: json['MaterialTransferTypeID'] as int,
      fromLocationID: json['FromLocationID'] as int,
      materialTransferID: json['MaterialTransferID'] as int,
      materialType: json['MaterialType'] as String,
      fromLocation: json['FromLocation'] as String);
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

LeakInspection _$LeakInspectionFromJson(Map<String, dynamic> json) {
  return LeakInspection(
      leakDetectionMethod: json['LeakDetectionMethod'] as String,
      coolingApplianceLeakInspectionID:
          json['CoolingApplianceLeakInspectionID'] as int,
      leakInspectionType: json['LeakInspectionType'] as String,
      estimatedLeakAmount: (json['EstimatedLeakAmount'] as num)?.toDouble(),
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
