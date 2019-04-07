class WorkOrder {
  String workOrderNumber;
  int workOrderStatusID;
  String address2;
  String workOrderType;
  String troubleTicketPriority;
  int workOrderStatusReasonID;
  String city;
  int workOrderTypeID;
  String location;
  int workItemCount;
  String state;
  String workOrderStatus;
  String zipcode;
  String countryCode;
  String instance;
  int iD;
  String scheduleDate;
  String dueDate;
  int locationID;
  int troubleTicketPriorityID;
  String address1;
  String purchaseOrderNumber;
  String workOrderStatusReason;
  int instanceID;
  List<WorkItem> workItem;
  String requestDetails;

  WorkOrder(
      {this.workOrderNumber,
        this.workOrderStatusID,
        this.address2,
        this.workOrderType,
        this.troubleTicketPriority,
        this.workOrderStatusReasonID,
        this.city,
        this.workOrderTypeID,
        this.location,
        this.workItemCount,
        this.state,
        this.workOrderStatus,
        this.zipcode,
        this.countryCode,
        this.instance,
        this.iD,
        this.scheduleDate,
        this.dueDate,
        this.locationID,
        this.troubleTicketPriorityID,
        this.address1,
        this.purchaseOrderNumber,
        this.workOrderStatusReason,
        this.instanceID,
        this.workItem,
        this.requestDetails});

  WorkOrder.fromJson(Map<String, dynamic> json) {
    workOrderNumber = json['WorkOrderNumber'];
    workOrderStatusID = json['WorkOrderStatusID'];
    address2 = json['Address2'];
    workOrderType = json['WorkOrderType'];
    troubleTicketPriority = json['TroubleTicketPriority'];
    workOrderStatusReasonID = json['WorkOrderStatusReasonID'];
    city = json['City'];
    workOrderTypeID = json['WorkOrderTypeID'];
    location = json['Location'];
    workItemCount = json['WorkItemCount'];
    state = json['State'];
    workOrderStatus = json['WorkOrderStatus'];
    zipcode = json['Zipcode'];
    countryCode = json['CountryCode'];
    instance = json['Instance'];
    iD = json['ID'];
    scheduleDate = json['ScheduleDate'];
    dueDate = json['DueDate'];
    locationID = json['LocationID'];
    troubleTicketPriorityID = json['TroubleTicketPriorityID'];
    address1 = json['Address1'];
    purchaseOrderNumber = json['PurchaseOrderNumber'];
    workOrderStatusReason = json['WorkOrderStatusReason'];
    instanceID = json['InstanceID'];
    if (json['WorkItem'] != null) {
      workItem = new List<WorkItem>();
      json['WorkItem'].forEach((v) {
        workItem.add(new WorkItem.fromJson(v));
      });
    }
    requestDetails = json['RequestDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WorkOrderNumber'] = this.workOrderNumber;
    data['WorkOrderStatusID'] = this.workOrderStatusID;
    data['Address2'] = this.address2;
    data['WorkOrderType'] = this.workOrderType;
    data['TroubleTicketPriority'] = this.troubleTicketPriority;
    data['WorkOrderStatusReasonID'] = this.workOrderStatusReasonID;
    data['City'] = this.city;
    data['WorkOrderTypeID'] = this.workOrderTypeID;
    data['Location'] = this.location;
    data['WorkItemCount'] = this.workItemCount;
    data['State'] = this.state;
    data['WorkOrderStatus'] = this.workOrderStatus;
    data['Zipcode'] = this.zipcode;
    data['CountryCode'] = this.countryCode;
    data['Instance'] = this.instance;
    data['ID'] = this.iD;
    data['ScheduleDate'] = this.scheduleDate;
    data['DueDate'] = this.dueDate;
    data['LocationID'] = this.locationID;
    data['TroubleTicketPriorityID'] = this.troubleTicketPriorityID;
    data['Address1'] = this.address1;
    data['PurchaseOrderNumber'] = this.purchaseOrderNumber;
    data['WorkOrderStatusReason'] = this.workOrderStatusReason;
    data['InstanceID'] = this.instanceID;
    if (this.workItem != null) {
      data['WorkItem'] = this.workItem.map((v) => v.toJson()).toList();
    }
    data['RequestDetails'] = this.requestDetails;
    return data;
  }
}

class WorkItem {
  int chargeCapacitySourceTypeID;
  String leakRepairDispositionType;
  int materialTypeID;
  int workItemTypeID;
  bool wasLeakFound;
  String workItemType;
  String chargeCapacitySourceType;
  String workItemStatus;
  double netGasLbsAdded;
  int gasLbsAdded;
  String verificationLeakDetectionMethod;
  List<LeakInspection> leakInspection;
  int materialTransferCount;
  int assetLocationID;
  int assetID;
  int workItemStatusID;
  String asset;
  String initialLeakDetectionMethod;
  int verificationLeakDetectionMethodID;
  double currentGasWeightLbs;
  int finalCoolingApplianceStatusID;
  int serviceActionID;
  String serviceAction;
  String assetLocation;
  int initialLeakDetectionMethodID;
  List<MaterialTransfer> materialTransfer;
  String partsRequired;
  String serviceDate;
  String notes;
  bool wasProblemResolved;
  String repairNotes;
  String repairTestResults;
  int serviceTransferReasonID;
  String dateOfFollowUpService;
  int leakRepairDispositionTypeID;
  String dateLeakFound;
  int gasLbsRemoved;
  double vacuumPSI;
  bool wasProperVacuumPulled;
  String materialType;
  int finalCoolingApplianceStatus;
  int leakInspectionCount;
  String serviceTransferReason;
  int workItemID;

  WorkItem(
      {this.chargeCapacitySourceTypeID,
        this.leakRepairDispositionType,
        this.materialTypeID,
        this.workItemTypeID,
        this.wasLeakFound,
        this.workItemType,
        this.chargeCapacitySourceType,
        this.workItemStatus,
        this.netGasLbsAdded,
        this.gasLbsAdded,
        this.verificationLeakDetectionMethod,
        this.leakInspection,
        this.materialTransferCount,
        this.assetLocationID,
        this.assetID,
        this.workItemStatusID,
        this.asset,
        this.initialLeakDetectionMethod,
        this.verificationLeakDetectionMethodID,
        this.currentGasWeightLbs,
        this.finalCoolingApplianceStatusID,
        this.serviceActionID,
        this.serviceAction,
        this.assetLocation,
        this.initialLeakDetectionMethodID,
        this.materialTransfer,
        this.partsRequired,
        this.serviceDate,
        this.notes,
        this.wasProblemResolved,
        this.repairNotes,
        this.repairTestResults,
        this.serviceTransferReasonID,
        this.dateOfFollowUpService,
        this.leakRepairDispositionTypeID,
        this.dateLeakFound,
        this.gasLbsRemoved,
        this.vacuumPSI,
        this.wasProperVacuumPulled,
        this.materialType,
        this.finalCoolingApplianceStatus,
        this.leakInspectionCount,
        this.serviceTransferReason,
        this.workItemID});

  WorkItem.fromJson(Map<String, dynamic> json) {
    chargeCapacitySourceTypeID = json['ChargeCapacitySourceTypeID'];
    leakRepairDispositionType = json['LeakRepairDispositionType'];
    materialTypeID = json['MaterialTypeID'];
    workItemTypeID = json['WorkItemTypeID'];
    wasLeakFound = json['WasLeakFound'];
    workItemType = json['WorkItemType'];
    chargeCapacitySourceType = json['ChargeCapacitySourceType'];
    workItemStatus = json['WorkItemStatus'];
    netGasLbsAdded = json['NetGasLbsAdded'];
    gasLbsAdded = json['GasLbsAdded'];
    verificationLeakDetectionMethod = json['VerificationLeakDetectionMethod'];
    if (json['LeakInspection'] != null) {
      leakInspection = new List<LeakInspection>();
      json['LeakInspection'].forEach((v) {
        leakInspection.add(new LeakInspection.fromJson(v));
      });
    }
    materialTransferCount = json['MaterialTransferCount'];
    assetLocationID = json['AssetLocationID'];
    assetID = json['AssetID'];
    workItemStatusID = json['WorkItemStatusID'];
    asset = json['Asset'];
    initialLeakDetectionMethod = json['InitialLeakDetectionMethod'];
    verificationLeakDetectionMethodID =
    json['VerificationLeakDetectionMethodID'];
    currentGasWeightLbs = json['CurrentGasWeightLbs'];
    finalCoolingApplianceStatusID = json['FinalCoolingApplianceStatusID'];
    serviceActionID = json['ServiceActionID'];
    serviceAction = json['ServiceAction'];
    assetLocation = json['AssetLocation'];
    initialLeakDetectionMethodID = json['InitialLeakDetectionMethodID'];
    if (json['MaterialTransfer'] != null) {
      materialTransfer = new List<MaterialTransfer>();
      json['MaterialTransfer'].forEach((v) {
        materialTransfer.add(new MaterialTransfer.fromJson(v));
      });
    }
    partsRequired = json['PartsRequired'];
    serviceDate = json['ServiceDate'];
    notes = json['Notes'];
    wasProblemResolved = json['WasProblemResolved'];
    repairNotes = json['RepairNotes'];
    repairTestResults = json['RepairTestResults'];
    serviceTransferReasonID = json['ServiceTransferReasonID'];
    dateOfFollowUpService = json['DateOfFollowUpService'];
    leakRepairDispositionTypeID = json['LeakRepairDispositionTypeID'];
    dateLeakFound = json['DateLeakFound'];
    gasLbsRemoved = json['GasLbsRemoved'];
    vacuumPSI = json['VacuumPSI'];
    wasProperVacuumPulled = json['WasProperVacuumPulled'];
    materialType = json['MaterialType'];
    finalCoolingApplianceStatus = json['FinalCoolingApplianceStatus'];
    leakInspectionCount = json['LeakInspectionCount'];
    serviceTransferReason = json['ServiceTransferReason'];
    workItemID = json['WorkItemID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ChargeCapacitySourceTypeID'] = this.chargeCapacitySourceTypeID;
    data['LeakRepairDispositionType'] = this.leakRepairDispositionType;
    data['MaterialTypeID'] = this.materialTypeID;
    data['WorkItemTypeID'] = this.workItemTypeID;
    data['WasLeakFound'] = this.wasLeakFound;
    data['WorkItemType'] = this.workItemType;
    data['ChargeCapacitySourceType'] = this.chargeCapacitySourceType;
    data['WorkItemStatus'] = this.workItemStatus;
    data['NetGasLbsAdded'] = this.netGasLbsAdded;
    data['GasLbsAdded'] = this.gasLbsAdded;
    data['VerificationLeakDetectionMethod'] =
        this.verificationLeakDetectionMethod;
    if (this.leakInspection != null) {
      data['LeakInspection'] =
          this.leakInspection.map((v) => v.toJson()).toList();
    }
    data['MaterialTransferCount'] = this.materialTransferCount;
    data['AssetLocationID'] = this.assetLocationID;
    data['AssetID'] = this.assetID;
    data['WorkItemStatusID'] = this.workItemStatusID;
    data['Asset'] = this.asset;
    data['InitialLeakDetectionMethod'] = this.initialLeakDetectionMethod;
    data['VerificationLeakDetectionMethodID'] =
        this.verificationLeakDetectionMethodID;
    data['CurrentGasWeightLbs'] = this.currentGasWeightLbs;
    data['FinalCoolingApplianceStatusID'] = this.finalCoolingApplianceStatusID;
    data['ServiceActionID'] = this.serviceActionID;
    data['ServiceAction'] = this.serviceAction;
    data['AssetLocation'] = this.assetLocation;
    data['InitialLeakDetectionMethodID'] = this.initialLeakDetectionMethodID;
    if (this.materialTransfer != null) {
      data['MaterialTransfer'] =
          this.materialTransfer.map((v) => v.toJson()).toList();
    }
    data['PartsRequired'] = this.partsRequired;
    data['ServiceDate'] = this.serviceDate;
    data['Notes'] = this.notes;
    data['WasProblemResolved'] = this.wasProblemResolved;
    data['RepairNotes'] = this.repairNotes;
    data['RepairTestResults'] = this.repairTestResults;
    data['ServiceTransferReasonID'] = this.serviceTransferReasonID;
    data['DateOfFollowUpService'] = this.dateOfFollowUpService;
    data['LeakRepairDispositionTypeID'] = this.leakRepairDispositionTypeID;
    data['DateLeakFound'] = this.dateLeakFound;
    data['GasLbsRemoved'] = this.gasLbsRemoved;
    data['VacuumPSI'] = this.vacuumPSI;
    data['WasProperVacuumPulled'] = this.wasProperVacuumPulled;
    data['MaterialType'] = this.materialType;
    data['FinalCoolingApplianceStatus'] = this.finalCoolingApplianceStatus;
    data['LeakInspectionCount'] = this.leakInspectionCount;
    data['ServiceTransferReason'] = this.serviceTransferReason;
    data['WorkItemID'] = this.workItemID;
    return data;
  }
}

class LeakInspection {
  String leakDetectionMethod;
  int coolingApplianceLeakInspectionID;
  String leakInspectionType;
  int estimatedLeakAmount;
  String faultCauseType;
  bool wasLeakFound;
  int faultCauseTypeID;
  String leakLocationCategory;
  String inspectionDate;
  String leakLocation;
  int leakLocationCategoryID;
  String notes;
  int leakLocationID;
  int leakDetectionMethodID;

  LeakInspection(
      {this.leakDetectionMethod,
        this.coolingApplianceLeakInspectionID,
        this.leakInspectionType,
        this.estimatedLeakAmount,
        this.faultCauseType,
        this.wasLeakFound,
        this.faultCauseTypeID,
        this.leakLocationCategory,
        this.inspectionDate,
        this.leakLocation,
        this.leakLocationCategoryID,
        this.notes,
        this.leakLocationID,
        this.leakDetectionMethodID});

  LeakInspection.fromJson(Map<String, dynamic> json) {
    leakDetectionMethod = json['LeakDetectionMethod'];
    coolingApplianceLeakInspectionID = json['CoolingApplianceLeakInspectionID'];
    leakInspectionType = json['LeakInspectionType'];
    estimatedLeakAmount = json['EstimatedLeakAmount'];
    faultCauseType = json['FaultCauseType'];
    wasLeakFound = json['WasLeakFound'];
    faultCauseTypeID = json['FaultCauseTypeID'];
    leakLocationCategory = json['LeakLocationCategory'];
    inspectionDate = json['InspectionDate'];
    leakLocation = json['LeakLocation'];
    leakLocationCategoryID = json['LeakLocationCategoryID'];
    notes = json['Notes'];
    leakLocationID = json['LeakLocationID'];
    leakDetectionMethodID = json['LeakDetectionMethodID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeakDetectionMethod'] = this.leakDetectionMethod;
    data['CoolingApplianceLeakInspectionID'] =
        this.coolingApplianceLeakInspectionID;
    data['LeakInspectionType'] = this.leakInspectionType;
    data['EstimatedLeakAmount'] = this.estimatedLeakAmount;
    data['FaultCauseType'] = this.faultCauseType;
    data['WasLeakFound'] = this.wasLeakFound;
    data['FaultCauseTypeID'] = this.faultCauseTypeID;
    data['LeakLocationCategory'] = this.leakLocationCategory;
    data['InspectionDate'] = this.inspectionDate;
    data['LeakLocation'] = this.leakLocation;
    data['LeakLocationCategoryID'] = this.leakLocationCategoryID;
    data['Notes'] = this.notes;
    data['LeakLocationID'] = this.leakLocationID;
    data['LeakDetectionMethodID'] = this.leakDetectionMethodID;
    return data;
  }
}

class MaterialTransfer {
  int fromAssetID;
  int toLocationID;
  int toAssetID;
  String toAsset;
  String transferDate;
  String notes;
  String fromAsset;
  int materialTypeID;
  int technicianID;
  String technicianName;
  String toLocation;
  String cylinderNotes;
  String materialTransferType;
  int transferWeightLbs;
  int materialTransferTypeID;
  int fromLocationID;
  int materialTransferID;
  String materialType;
  String fromLocation;

  MaterialTransfer(
      {this.fromAssetID,
        this.toLocationID,
        this.toAssetID,
        this.toAsset,
        this.transferDate,
        this.notes,
        this.fromAsset,
        this.materialTypeID,
        this.technicianID,
        this.technicianName,
        this.toLocation,
        this.cylinderNotes,
        this.materialTransferType,
        this.transferWeightLbs,
        this.materialTransferTypeID,
        this.fromLocationID,
        this.materialTransferID,
        this.materialType,
        this.fromLocation});

  MaterialTransfer.fromJson(Map<String, dynamic> json) {
    fromAssetID = json['FromAssetID'];
    toLocationID = json['ToLocationID'];
    toAssetID = json['ToAssetID'];
    toAsset = json['ToAsset'];
    transferDate = json['TransferDate'];
    notes = json['Notes'];
    fromAsset = json['FromAsset'];
    materialTypeID = json['MaterialTypeID'];
    technicianID = json['TechnicianID'];
    technicianName = json['TechnicianName'];
    toLocation = json['ToLocation'];
    cylinderNotes = json['CylinderNotes'];
    materialTransferType = json['MaterialTransferType'];
    transferWeightLbs = json['TransferWeightLbs'];
    materialTransferTypeID = json['MaterialTransferTypeID'];
    fromLocationID = json['FromLocationID'];
    materialTransferID = json['MaterialTransferID'];
    materialType = json['MaterialType'];
    fromLocation = json['FromLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FromAssetID'] = this.fromAssetID;
    data['ToLocationID'] = this.toLocationID;
    data['ToAssetID'] = this.toAssetID;
    data['ToAsset'] = this.toAsset;
    data['TransferDate'] = this.transferDate;
    data['Notes'] = this.notes;
    data['FromAsset'] = this.fromAsset;
    data['MaterialTypeID'] = this.materialTypeID;
    data['TechnicianID'] = this.technicianID;
    data['TechnicianName'] = this.technicianName;
    data['ToLocation'] = this.toLocation;
    data['CylinderNotes'] = this.cylinderNotes;
    data['MaterialTransferType'] = this.materialTransferType;
    data['TransferWeightLbs'] = this.transferWeightLbs;
    data['MaterialTransferTypeID'] = this.materialTransferTypeID;
    data['FromLocationID'] = this.fromLocationID;
    data['MaterialTransferID'] = this.materialTransferID;
    data['MaterialType'] = this.materialType;
    data['FromLocation'] = this.fromLocation;
    return data;
  }
}