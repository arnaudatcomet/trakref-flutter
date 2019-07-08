import "package:flutter/material.dart";
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/screens/adding/app_cancellable_textfield_widget.dart';
import 'package:trakref_app/screens/adding/material_transfer/material_transfer_widget.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';

// 2, 3, 5, 0
enum ServiceType { LeakInspection, ServiceAndLeakRepair, Shutdown, None }

class PageServiceEventAddBloc extends StatefulWidget {
  List<Asset> assets;
  WorkOrder currentWorkOrder;

  @override
  _PageServiceEventAddBlocState createState() =>
      _PageServiceEventAddBlocState();

  PageServiceEventAddBloc({this.assets, this.currentWorkOrder});
}

class _PageServiceEventAddBlocState extends State<PageServiceEventAddBloc> {
  List<Dropdown> locations;

  // Need to check what it is in the dropdown API
// List<Dropdown> temperatureClass;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<Asset> coolingApplianceAssets;
  bool _isDropdownsLoaded = false;
  ServiceType typeOfService = ServiceType.None;

  List<DropdownItem> serviceType = [
    DropdownItem(name: 'Leak Inspection', id: 2),
    DropdownItem(name: 'Service and Leak Repair', id: 3),
    DropdownItem(name: 'Shutdown', id: 5)
  ];

  List<DropdownItem> wasLeakFound = [
    DropdownItem(name: 'Yes', id: 1),
    DropdownItem(name: 'No', id: 0)
  ];

  List<DropdownItem> assetsDropdowns;
  List<LeakLocationItem> initialLocationLeakFound;
  List<LeakLocationItem> verificationLocationLeakFound;
  List<DropdownItem> _filteredInitialLocationLeakFound;
  List<DropdownItem> _filteredVerificationLocationLeakFound;
  List<DropdownItem> categoriesLeakFound;
  List<DropdownItem> categoryLocationLeakFound;
  List<DropdownItem> causeOfLeaks;
  List<DropdownItem> leakDetectionMethod;
  List<DropdownItem> serviceActions;
  List<DropdownItem> leakRepairStatus;
  List<DropdownItem> serviceTransferReason;
  List<DropdownItem> shutdownStatus = [
    DropdownItem(name: 'Shutdown', id: 6),
    DropdownItem(name: 'Mothball', id: 2),
    DropdownItem(name: 'Pending Install', id: 12),
  ];
  List<DropdownItem> depthVacuumAmount = _buildDropdownInt(0, 31);

  // UI Control variables
  bool _wasLeakFound;
  bool _wasVerificationLeakFound = false;

  // Form values
  DropdownItem _pickedEquipmentWorkedOn;
  DropdownItem _pickedTypeOfService;
  DropdownItem _pickedLeakDetectionMethod;
  DateTime _pickedServiceDate;
  DropdownItem _pickedCauseOfLeak;
  double _pickedEstimatedLeakAmount;
  TextEditingController _estimatedLeakAmountController = TextEditingController();

  DropdownItem _pickedInitialLeakCategory;
  DropdownItem _pickedInitialLeakLocation;
  DropdownItem _pickedVerificationLeakCategory;
  DropdownItem _pickedVerificationLeakLocation;
  DropdownItem _pickedVerificationLeakDetectionMethod;
  DropdownItem _pickedVerificationCauseOfLeak;
  DropdownItem _pickedServiceTransferReason;
  DropdownItem _pickedWasVacuumPulled;
  DropdownItem _pickedDepthOfVacuum;
  DropdownItem _pickedServiceAction;
  DropdownItem _pickedLeakRepairStatus;
  DropdownItem _pickedShutdownStatus;
  DateTime _pickedFollowUpDate;
  DateTime _pickeVerificationDate;
  List<MaterialTransfer> _pickedMaterialTransfers = [];
  String _pickedObservationNotes;

  void onEstimatedAmountChanged() {
    print("onEstimatedAmountChanged");
    try {
      _pickedEstimatedLeakAmount =
          double.parse(_estimatedLeakAmountController.text);
      print("onEstimatedAmountChanged : $_pickedEstimatedLeakAmount");
    }
    catch (error) {
      _pickedEstimatedLeakAmount = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    // Listen to textfield
    _estimatedLeakAmountController.addListener(onEstimatedAmountChanged);

    // Get the dropdowns
    _isDropdownsLoaded = false;
    DropdownList results = CachingAPIService().cachedDropdowns ?? [];
    // TrakrefAPIService().getDropdown().then((results) {
      print("AssetDropdowns ${widget.assets}");
      // Map the list of assets to a dropdown sources
      setState(() {
        this.initialLocationLeakFound = results.leakLocations;
        this.verificationLocationLeakFound = results.leakLocations;
        this.categoriesLeakFound = results.leakLocationCategories;
        this.causeOfLeaks = results.causeOfLeaks;
        this.leakDetectionMethod = results.leakDetectionMethods;
        this.serviceTransferReason = results.purposesForAddingGas;

        this.serviceActions = results.serviceActions;
        this.leakRepairStatus = results.leakRepairStatuses;

        // Get the assets
        print(
            "getCylinders for locations[${widget.currentWorkOrder
                .locationID}]");

        TrakrefAPIService()
            .getCylinders([widget.currentWorkOrder.locationID])
            .then((assets) {
          // Add a fix for the cooling appliance status ; it will throw an error for shutdown service event
          coolingApplianceAssets =
              assets.where((i) => (i.coolingApplianceStatusID > 0)).toList();
          coolingApplianceAssets = assets;
          assets.forEach((i) => print("${i.name} / ${i.materialTypeID} / ${i.isCylinder}"));
          assetsDropdowns = (coolingApplianceAssets ?? []).where((i) => (i.isCylinder == false && i.materialTypeID != 0)).map((i) {
            return DropdownItem(name: i.name, id: i.assetID);
          }).toList();
          assetsDropdowns.sort((item1, item2) => item1.name.compareTo(item2.name));
          _isDropdownsLoaded = true;
          // Show a warning if there's no cooling assets
          if (coolingApplianceAssets.length < 1) {
            FormBuild.showFlushBarMessage(context,
                "No equipment/cooling appliance found for that work order",
                    () {
              Navigator.of(context).pop();
                });
          }
          setState(() {});
        });
      });
    // });
  }

  @override
  void dispose() {
    _estimatedLeakAmountController.dispose();
    super.dispose();
  }

  void resetPickedValues() {
    _pickedEquipmentWorkedOn = null;
    _pickedTypeOfService = null;
    _pickedLeakDetectionMethod = null;
    _pickedServiceDate = null;
    _wasLeakFound = null;
    typeOfService = ServiceType.None;
    _wasVerificationLeakFound = false;

    resetLeakWasFoundPickedValues();
    _pickedMaterialTransfers = [];
  }

  void resetLeakWasFoundPickedValues() {
    // We will reset this values as the wasLeakFound implies other UI display
    _wasLeakFound = null;

    _pickedCauseOfLeak = null;
    _pickedEstimatedLeakAmount = null;
    _pickedInitialLeakCategory = null;
    _pickedInitialLeakLocation = null;
    _pickedVerificationLeakCategory = null;
    _pickedVerificationLeakLocation = null;
    _pickedWasVacuumPulled = null;
    _pickedDepthOfVacuum = null;
    _pickedServiceAction = null;
    _pickedLeakRepairStatus = null;
    _pickedShutdownStatus = null;
    _pickedFollowUpDate = null;
    _pickedObservationNotes = null;
    _wasVerificationLeakFound = null;
  }

  // Submit Service Event - Leak Inspection
  Future<bool> submitLeakInspection() async {
    // Retrieve the values
    int equipmentWorkedOn = _pickedEquipmentWorkedOn.id;
    String typeOfService = _pickedTypeOfService.name;
    String leakDetectionMethod = _pickedLeakDetectionMethod.name;
    bool wasLeakFound = _wasLeakFound;
    String serviceDate = null;
    if (_pickedServiceDate != null) {
      serviceDate = DateFormat(kShortDateFormat).format(_pickedServiceDate);
    }
    String notes = _pickedObservationNotes;

    print("equipmentWorkedOn : $equipmentWorkedOn");
    print("typeOfService : $typeOfService");
    print("leakDetectionMethod : $leakDetectionMethod");
    print("wasLeakFound : $wasLeakFound");
    print("serviceDate : $serviceDate");

    // If we found a leak
    List<LeakInspection> leakInspections = [];
    if (wasLeakFound == true) {
      // Values from the forms
      int leakCategory = _pickedInitialLeakCategory.id;
      int causeLeak = _pickedCauseOfLeak.id;
      int leakDetectionMethod = _pickedLeakDetectionMethod.id;
      double estimatedLeakAmount = _pickedEstimatedLeakAmount;
      String followUpDateString;
      if (_pickedFollowUpDate != null) {
        followUpDateString =
            DateFormat(kShortDateFormat).format(_pickedFollowUpDate);
        print("followUpDate $followUpDateString");
      }

      print("leakCategory : ${_pickedInitialLeakCategory.name}");
      print("causeLeak : ${_pickedCauseOfLeak.name}");
      print("estimatedLeakAmount : $estimatedLeakAmount");
      print("followUpDateString : $followUpDateString");
      print("notes : $notes");

      LeakInspection inspection = LeakInspection(
          leakLocationCategoryID: leakCategory,
          faultCauseTypeID: causeLeak,
          estimatedLeakAmount: estimatedLeakAmount,
          leakDetectionMethodID: leakDetectionMethod,
          notes: notes,
          wasLeakFound: wasLeakFound,
          inspectionDate: followUpDateString);

      leakInspections = [inspection];
    }

    // Create the WorkOrder and Submit it
    // For the sake of purpose we don't touch the Work Order part, only the service event part


    WorkOrder order = widget.currentWorkOrder;
    order.workItemCount = 1;
    order.workItem = [
      WorkItem(
          wasLeakFound: wasLeakFound,
          assetID: equipmentWorkedOn,
          workItemTypeID: 2,
          // It's invalid if WorkItem type != 3, 2 and 5
          serviceDate: serviceDate,
          workItemStatusID: 1,
          // Repair
          repairNotes: notes,
          leakInspectionCount: 1,
          leakInspection: leakInspections)
    ];

    // For testing purpose only
//    TrakrefAPIService().writeOrderOnDisk([order]);
    TrakrefAPIService().writeOnDisk<WorkOrder>([order]);

    // Post the work order
    return await TrakrefAPIService().postWorkOrder(order);
  }

  // Submit Service Event - Service and Leak Repair
  Future<bool> submitServiceAndLeakRepair() async {
    // Retrieve the values
    int equipmentWorkedOn = _pickedEquipmentWorkedOn.id;

    String typeOfService = _pickedTypeOfService.name;
    String leakDetectionMethod = _pickedLeakDetectionMethod.name;
    bool wasLeakFound = _wasLeakFound;
    String serviceDate;
    if (_pickedServiceDate != null) {
      serviceDate =
          DateFormat(kShortTimeDateFormat).format(_pickedServiceDate);
    }

    String leakCategory = _pickedInitialLeakCategory.name;
    String leakLocation = _pickedInitialLeakLocation.name;
    String causeOfLeak = _pickedCauseOfLeak.name;
    String estimatedLeakAmount = _pickedEstimatedLeakAmount.toString();
    String serviceAction = _pickedServiceAction.name;
    String leakRepairStatus = _pickedLeakRepairStatus.name;
    String serviceTransferReason = _pickedServiceTransferReason.name;

    String verificationServiceDate;
    if (_pickeVerificationDate != null) {
      verificationServiceDate =
          DateFormat(kShortTimeDateFormat).format(_pickeVerificationDate);
    }
    String verificationLeakMethod =
        _pickedVerificationLeakDetectionMethod.name;
    bool verificationWasLeakFoundDuringInspection = _wasVerificationLeakFound;
    String verificationCauseOfLeak = _pickedVerificationCauseOfLeak?.name;
    String verificationLeakCategory = _pickedVerificationLeakCategory?.name;
    String verificationLeakLocation = _pickedVerificationLeakLocation?.name;

    String notes = _pickedObservationNotes;

    print("=== submitServiceAndLeakRepair ===");
    print("> equipmentWorkedOn : $equipmentWorkedOn");
    print("> typeOfService : $typeOfService");
    print("> leakDetectionMethod : $leakDetectionMethod");
    print("> wasLeakFound : $wasLeakFound");
    print("> leakCategory : $leakCategory");
    print("> leakLocation : $leakLocation");
    print("> causeOfLeak : $causeOfLeak");
    print("> serviceDate : $serviceDate");
    print("> estimatedLeakAmount : $estimatedLeakAmount");
    print("> serviceAction : $serviceAction");
    print("> serviceTransferReason : $serviceTransferReason");
    print("> leakRepairStatus : $leakRepairStatus");
    print("> followUpServiceDate : $verificationServiceDate");
    print("> verificationLeakMethod : $verificationLeakMethod");
    print(
        "> verificationWasLeakFoundDuringInspection : $verificationWasLeakFoundDuringInspection");
    print("> verificationCauseOfLeak : $verificationCauseOfLeak");
    print("> verificationLeakCategory : $verificationLeakCategory");
    print("> verificationLeakLocation : $verificationLeakLocation");

    for (MaterialTransfer transfer in _pickedMaterialTransfers) {
      print("=== MaterialTransfer ===");
      print("> transferWeightLbs : ${transfer.transferWeightLbs} lbs");
      print("> fromAsset : ${transfer.fromAsset}");
      print("> toAsset : ${transfer.toAsset}");
      print("> transferDate : ${transfer.transferDate}");
    }

    // Construct the work order to POST
    print("### workOrderNumber : ${widget.currentWorkOrder.workOrderNumber}");
    print("### instanceID : ${widget.currentWorkOrder.instanceID}");
    print("### workOrderType : ${widget.currentWorkOrder.workOrderType}");

    // Create the leak inspection 'Initial'
    LeakInspection initialLeakInspection = LeakInspection(
        leakLocationCategoryID: _pickedInitialLeakCategory.id,
        leakLocationID: _pickedInitialLeakLocation.id,
        faultCauseTypeID: _pickedCauseOfLeak.id,
        estimatedLeakAmount: _pickedEstimatedLeakAmount,
        leakInspectionType: "initial",
        wasLeakFound: _wasLeakFound,
        leakDetectionMethodID: _pickedLeakDetectionMethod.id);

    LeakInspection verificationLeakInspection = LeakInspection(
        leakLocationCategoryID: _pickedVerificationLeakCategory?.id ?? 0,
        leakLocationID: _pickedVerificationLeakLocation?.id ?? 0,
        faultCauseTypeID: _pickedVerificationCauseOfLeak?.id ?? 0,
        leakInspectionType: "verification",
        // Need to change that
        wasLeakFound: verificationWasLeakFoundDuringInspection,
        leakDetectionMethodID: _pickedVerificationLeakDetectionMethod?.id ?? 0);

    // You need to grab the locationID to pass it to workItem ID
    WorkOrder order = widget.currentWorkOrder;

    // Create the work item
    WorkItem item = WorkItem(
        assetID: equipmentWorkedOn,
        assetLocationID: order.locationID,
        workItemTypeID: 3,
        // Open by default
        workItemStatusID: 1,
        serviceDate: serviceDate,
        wasLeakFound: wasLeakFound,
        repairNotes: notes,
        serviceTransferReasonID: _pickedServiceTransferReason.id,
        serviceActionID: _pickedServiceAction.id,
        leakRepairDispositionTypeID: _pickedLeakRepairStatus.id,
        dateOfFollowUpService: verificationServiceDate,
        leakInspectionCount: 2,
        leakInspection: [initialLeakInspection, verificationLeakInspection],
        materialTransfer: _pickedMaterialTransfers,
        materialTransferCount: _pickedMaterialTransfers.length);

    order.workItemCount = 1;
    order.workItem = [item];

    print("order ${order.toJson()}");
    print("item ${order.workItem.first.toJson()}");
//      print("materialTransfer ${order.workItem.first.materialTransfer.first.toJson()}");

    // For testing purpose only
    TrakrefAPIService().writeOnDisk<WorkOrder>([order]);

    // Post the work order
    return await TrakrefAPIService().postWorkOrder(order);
  }

  // Submit Service Event - Shutdown
  Future<dynamic> submitShutdown() async {
    // Retrieve the values
    int equipmentWorkedOn = _pickedEquipmentWorkedOn.id;
    String typeOfService = _pickedTypeOfService.name;
    // We don't actually need those values
    // String leakDetectionMethod = _pickedLeakDetectionMethod.name;
    // bool wasLeakFound = _wasLeakFound;
    
    // By default
    String leakDetectionMethod = null;
    bool wasLeakFound = false;
    
    String serviceDate;
    if (_pickedServiceDate != null) {
      serviceDate = DateFormat(kShortDateFormat).format(_pickedServiceDate);
    }
    String notes = _pickedObservationNotes;

    bool wasVacuumPulled = false;
    if (_pickedWasVacuumPulled.name == "Yes") {
      wasVacuumPulled = true;
    } else if (_pickedWasVacuumPulled.name == "No") {
      wasVacuumPulled = false;
    }

    double depthOfVacuum = 0;
    try {
      depthOfVacuum = double.parse(_pickedDepthOfVacuum.name);
    }
    catch (error) {
      // Do something
    }

    String serviceAction = _pickedServiceAction.name;
    String shutdownStatus = _pickedShutdownStatus.name;

    print("=== submitShutdown ===");
    print("> equipmentWorkedOn : $equipmentWorkedOn");
    print("> typeOfService : $typeOfService");
    print("> leakDetectionMethod : $leakDetectionMethod");
    print("> wasLeakFound : $wasLeakFound");
    print("> serviceDate : $serviceDate");
    print("> wasVacuumPulled : $wasVacuumPulled");
    print("> depthOfVacuum : $depthOfVacuum");
    print("> serviceAction : $serviceAction");
    print("> shutdownStatus : $shutdownStatus");


    // You need to grab the locationID to pass it to workItem ID
    WorkOrder order = widget.currentWorkOrder;

//      print("> shutdownStatus : $shutdownStatus");

    // Create the work item
    WorkItem item = WorkItem(
        assetID: equipmentWorkedOn,
        assetLocationID: order.locationID,
        workItemTypeID: 5,
        // Open by default
        workItemStatusID: 1,
        serviceDate: serviceDate,
        wasLeakFound: wasLeakFound,
        vacuumPSI: depthOfVacuum,
        repairNotes: notes,
        finalCoolingApplianceStatusID: _pickedShutdownStatus.id,
        serviceActionID: _pickedServiceAction.id,
        leakInspectionCount: 1,
        leakInspection: [],
        wasProperVacuumPulled: wasVacuumPulled,
        materialTransfer: _pickedMaterialTransfers,
        materialTransferCount: _pickedMaterialTransfers.length);

    order.workItem = [item];
    order.workItemCount = 1;

    TrakrefAPIService().writeOnDisk<WorkOrder>([order]);

    // Post the work order
    return await TrakrefAPIService().postWorkOrder(order);
  }

  // Build Vacuum dept dynamically
  static List<DropdownItem> _buildDropdownInt(int from, int length) {
    List<DropdownItem> intList = List<DropdownItem>();
    for (var i = from; i <= (from + length); i++) {
      intList.add(DropdownItem(name: '$i', id: i));
    }
    return intList;
  }

  String _getServiceTypeRaw(ServiceType type) {
    if (type == ServiceType.LeakInspection) {
      return "Leak Inspection";
    } else if (type == ServiceType.ServiceAndLeakRepair) {
      return "Service Repair";
    } else if (type == ServiceType.Shutdown) {
      return "Shutdown";
    }
    return "";
  }

  Widget _buildTitle(ServiceType type) {
    if (type == ServiceType.None) {
      return Row(
        children: <Widget>[
          Expanded(
              flex: (type == ServiceType.None) ? 1 : 2,
              child: Text(
                "Add Service Event",
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              )),
          (type == ServiceType.None)
              ? Container()
              : Expanded(
            flex: 1,
            child: Chip(
              backgroundColor: AppColors.blueTurquoise,
              label: Text('${_getServiceTypeRaw(type)} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          )
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                "Add Service Event",
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              )),
          Expanded(
            flex: 1,
            child: Chip(
              backgroundColor: AppColors.blueTurquoise,
              label: Text('${_getServiceTypeRaw(type)} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          )
        ],
      );
    }
  }

  Widget _buildMaterialTransfer(ServiceType type) {
    List<MaterialGasInstallType> allowedMaterialTransfer = [];
    if (type == ServiceType.LeakInspection) {
      return Container();
    }

    if (type == ServiceType.ServiceAndLeakRepair) {
      allowedMaterialTransfer = [
        MaterialGasInstallType.Recovery,
        MaterialGasInstallType.Install,
      ];
    } else if (type == ServiceType.Shutdown) {
      allowedMaterialTransfer = [MaterialGasInstallType.Recovery];
    }

    print("coolingApplianceAssets $coolingApplianceAssets");
    print("_pickedMaterialTransfers $_pickedMaterialTransfers");

    return MaterialTransfersWidget(
      serviceType: type,
      allowedTransfers: allowedMaterialTransfer,
      assets: coolingApplianceAssets,
      materialTransfers: _pickedMaterialTransfers,
      equipmentWorkedOnID: _pickedEquipmentWorkedOn.id,
      equipementWorkedOnName: _pickedEquipmentWorkedOn.name,
    );
  }

  Widget _buildInspection(bool leakFound, ServiceType type,
      {bool verificationLeakFound}) {
    print(
        "===> leakFound ? $leakFound, verification ? $verificationLeakFound, type ? $type");
    // Show leak inspection
    if (leakFound == true) {
      if (type == ServiceType.LeakInspection) {
        print("===> buildLeakInspection");
        return Column(
          key: Key("kbuildLeakInspection"),
          children: <Widget>[
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedInitialLeakCategory,
                    sourcesDropdown: this.categoriesLeakFound,
                    textKey: kInitialLeakCategoryKey,
                    textLabel: kInitialLeakCategory,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedInitialLeakCategory = value;
                      _pickedInitialLeakLocation = null;
                      setState(() {});
                    }),
              ],
            ),
            (this._filteredInitialLocationLeakFound != null)
                ? Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedInitialLeakLocation,
                    sourcesDropdown:
                    this._filteredInitialLocationLeakFound,
                    textKey: kInitialLeakLocationKey,
                    textLabel: kInitialLeakLocation,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedInitialLeakLocation = value;
                    })
              ],
            )
                : Container(),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedCauseOfLeak,
                    sourcesDropdown: this.causeOfLeaks,
                    textKey: kCauseOfLeakKey,
                    textLabel: kCauseOfLeak,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedCauseOfLeak = value;
                    })
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildTextField(
                    textController: _estimatedLeakAmountController,
                    onValidated: (value) {
                      if (value.isEmpty || value == null) {
                        return "Required";
                      }
                      try {
                        double amountEstimatedValue = double.parse(value);
                      }
                      catch (error) {
                        return "Amount input is not valid";
                      }
                    },
                    onSubmitted: (value) {
                      print("kEstimatedLeakAmountKey > onSubmitted $value");
                      double leakAmount = double.parse(value);
                      if (leakAmount != null) {
                        _pickedEstimatedLeakAmount = leakAmount;
                      }
                    },
                    inputType: TextInputType.text,
                    key: Key(kEstimatedLeakAmountKey),
                    label: kEstimatedLeakAmount),
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDatePicker(
                    onValidated: (value) {
                      if (_pickedFollowUpDate == null)
                        return "No service date found for service event";
                      if (_pickedFollowUpDate.isAfter(_pickedServiceDate) ==
                          false)
                        return "Date of Followup Service must be on or after Initial Leak Test Date";
                    },
                    onPressed: (value) {
                      print(
                          "$kServiceDateKey buildDatePicker > onPressed is $value");
                      _pickedFollowUpDate = value;
                    },
                    key: Key(kFollowUpDateKey),
                    helper: kFollowUpDate)
              ],
            )
          ],
        );
      } else if (type == ServiceType.ServiceAndLeakRepair) {
        print("===> ServiceAndLeakRepair");
        return Column(
          key: Key("kbuildServiceAndLeakRepair"),
          children: <Widget>[
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedInitialLeakCategory,
                    sourcesDropdown: this.categoriesLeakFound,
                    textKey: kInitialLeakCategoryKey,
                    textLabel: kInitialLeakCategory,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      // Cancel the subcategories
                      _pickedInitialLeakCategory = value;
                      _pickedInitialLeakLocation = null;
                      setState(() {
                        this._filteredInitialLocationLeakFound = null;
                      });
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (value is DropdownItem) {
                          // Get the filtered leak location category
                          List<LeakLocationItem> selectedLeakLocationList = this
                              .initialLocationLeakFound
                              .where((i) => i.categoryID == value.id)
                              .toList();
                          List<DropdownItem> categoryLeaksLocation =
                          selectedLeakLocationList
                              .map((i) =>
                              DropdownItem(id: i.id, name: i.name))
                              .toList();
                          setState(() {
                            if (categoryLeaksLocation.length == 0) {
                              this._filteredInitialLocationLeakFound = null;
                            } else {
                              this._filteredInitialLocationLeakFound =
                                  categoryLeaksLocation;
                            }
                          });
                        }
                      });
                    })
              ],
            ),
            (this._filteredInitialLocationLeakFound != null)
                ? Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedInitialLeakLocation,
                    sourcesDropdown:
                    this._filteredInitialLocationLeakFound,
                    textKey: kInitialLeakLocationKey,
                    textLabel: kInitialLeakLocation,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedInitialLeakLocation = value;
                    }),
              ],
            )
                : Container(),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedCauseOfLeak,
                    sourcesDropdown: this.causeOfLeaks,
                    textKey: kCauseOfLeakKey,
                    textLabel: kCauseOfLeak,
                    textError:
                    "Cause of Leak required since WasLeakFound was clicked for leak inspection service event",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedCauseOfLeak = value;
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                // Need to change that
                FormBuild.buildTextField(
                    key: Key(kEstimatedLeakAmountKey),
                    label: kEstimatedLeakAmount,
                    inputType: TextInputType.number)
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedServiceAction,
                    sourcesDropdown: this.serviceActions,
                    textKey: kServiceAndLeakRepairServiceActionKey,
                    textLabel: kServiceAction,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedServiceAction = value;
                    })
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedServiceTransferReason,
                    sourcesDropdown: this.serviceTransferReason,
                    textKey: kServiceAndLeakRepairServiceTransferReasonKey,
                    textLabel: kTransferReason,
                    textError: "Required",
                    isRequired: (_pickedMaterialTransfers.length > 0) ?? false,
                    onChangedValue: (value) {
                      _pickedServiceTransferReason = value;
                    })
              ],
            ),
            // URGENT: Need to add material gas
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedLeakRepairStatus,
                    sourcesDropdown: this.leakRepairStatus,
                    textKey: kLeakRepairStatusKey,
                    textLabel: kLeakRepairStatus,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedLeakRepairStatus = value;
                    })
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDatePicker(
                    onValidated: (value) {
                      if (_pickeVerificationDate == null)
                        return "No service date found for service event";
                      if (_pickeVerificationDate.isAfter(_pickedServiceDate) ==
                          false)
                        return "Date of Followup Service must be on or after Initial Leak Test Date";
                    },
                    onPressed: (value) {
                      print(
                          "$kServiceDateKey buildDatePicker > onPressed is $value");
                      _pickeVerificationDate = value;
                    },
                    key: Key(kVerificationDateKey),
                    helper: kVerificationDate)
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedVerificationLeakDetectionMethod,
                    sourcesDropdown: this.leakDetectionMethod,
                    textKey: kVerificationLeakMethodKey,
                    textLabel: kVerificationLeakMethod,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedVerificationLeakDetectionMethod = value;
                    })
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _wasVerificationLeakFound,
                    sourcesDropdown: this.wasLeakFound,
                    textKey: kVerificationWasLeakFoundKey,
                    textLabel: kVerificationWasLeakFound,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      setState(() {
                        this._filteredVerificationLocationLeakFound = [];
                        if (value?.name == "Yes") {
                          _wasVerificationLeakFound = true;
                        } else {
                          _wasVerificationLeakFound = false;
                        }
                      });
                    })
              ],
            ),
            // Note : maybe a better way to do the UI below
            (_wasVerificationLeakFound != null && _wasVerificationLeakFound == true)
                ? Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedVerificationCauseOfLeak,
                    sourcesDropdown: this.causeOfLeaks,
                    textKey: kVerificationLeakCauseKey,
                    textLabel: kVerificationLeakCause,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      print("kVerificationLeakCauseKey > $value");
                      _pickedVerificationCauseOfLeak = value;
                    }),
              ],
            )
                : Container(),
            (_wasVerificationLeakFound != null && _wasVerificationLeakFound == true)
                ? Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedVerificationLeakCategory,
                    sourcesDropdown: this.categoriesLeakFound,
                    textKey: kVerificationLeakCategoryKey,
                    textLabel: kVerificationLeakCategory,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      // Cancel the subcategories
                      _pickedVerificationLeakCategory = value;
                      _pickedVerificationLeakLocation = null;
                      setState(() {
                        this._filteredVerificationLocationLeakFound =
                        null;
                      });
                      Future.delayed(const Duration(milliseconds: 500),
                              () {
                            if (value is DropdownItem) {
                              // Get the filtered leak location category
                              List<LeakLocationItem>
                              selectedLeakLocationList = this
                                  .verificationLocationLeakFound
                                  .where((i) => i.categoryID == value.id)
                                  .toList();
                              List<DropdownItem> categoryLeaksLocation =
                              selectedLeakLocationList
                                  .map((i) =>
                                  DropdownItem(
                                      id: i.id, name: i.name))
                                  .toList();
                              setState(() {
                                if (categoryLeaksLocation.length == 0) {
                                  this._filteredVerificationLocationLeakFound =
                                  [];
                                } else {
                                  this._filteredVerificationLocationLeakFound =
                                      categoryLeaksLocation;
                                }
                              });
                            }
                          });
                    }),
              ],
            )
                : Container(),
            ((_wasVerificationLeakFound != null && _wasVerificationLeakFound == true) &&
                this._filteredVerificationLocationLeakFound != null)
                ? Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedVerificationLeakLocation,
                    sourcesDropdown:
                    this._filteredVerificationLocationLeakFound,
                    textKey: kVerificationLeakLocationKey,
                    textLabel: kVerificationLeakLocation,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedVerificationLeakLocation = value;
                    }),
              ],
            )
                : Container()
          ],
        );
      } else if (type == ServiceType.Shutdown) {
        print("===> buildShutdown");
        return Column(
          key: Key("kbuildShutdown"),
          children: <Widget>[
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedWasVacuumPulled,
                    sourcesDropdown: this.wasLeakFound,
                    textKey: kWasVacuumPulledKey,
                    textLabel: kWasVacuumPulled,
                    textError:
                    "No value for WasProperVacuumPulled found for shutdown service event",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedWasVacuumPulled = value;
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedDepthOfVacuum,
                    sourcesDropdown: depthVacuumAmount,
                    textKey: kDepthOfVacuumKey,
                    textLabel: kDepthOfVacuum,
                    isRequired: false,
                    onChangedValue: (value) {
                      _pickedDepthOfVacuum = value;
                    })
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedServiceAction,
                    sourcesDropdown: serviceActions,
                    textKey: kShutdownServiceActionKey,
                    textLabel: kServiceAction,
                    isRequired: true,
                    textError: "Required",
                    onChangedValue: (value) {
                      _pickedServiceAction = value;
                    })
              ],
            ),
            Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedShutdownStatus,
                    sourcesDropdown: shutdownStatus,
                    textKey: kPostShutdownStatusKey,
                    textLabel: kPostShutdownStatus,
                    isRequired: true,
                    textError: "Required",
                    onChangedValue: (value) {
                      _pickedShutdownStatus = value;
                    })
              ],
            )
          ],
        );
      }
    }
    return Container();
  }

  void showConfirmationMessage(bool onSucceeded) {
    String message = (onSucceeded) ? kAddServiceEventSuccessfulMessage : kAddServiceEventErrorMessage;
    Flushbar(
      duration:  Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.white,
      boxShadows: [BoxShadow(color: Colors.black, offset: Offset(0.0, 0.2), blurRadius: 0.0)],
      messageText: Text(message),
      mainButton: FlatButton(
        onPressed: () {},
        child: FlatButton(onPressed: () {
          Flushbar().dismiss();
        }, child: Text(
          "GOT IT", //dismiss
          style: TextStyle(color: Colors.black),
        )),
      ),
    )..show(context).then((r){
      if (onSucceeded) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    var addServiceEventListView = ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      _buildTitle(this.typeOfService),
                      Row(children: <Widget>[
                        AppCancellableTextField(
                            initialValue: _pickedEquipmentWorkedOn,
                            sourcesDropdown: assetsDropdowns,
                            textLabel: kEquipmentWorkedOn,
                            textError: "Required",
                            isRequired: true,
                            textKey: kEquipmentWorkedOnKey,
                            onChangedValue: (value) {
                              _pickedEquipmentWorkedOn = value;
                              // To show the material transfer part
                              setState(() {});
                            }),
                      ]),
                      Row(children: <Widget>[
                        AppCancellableTextField(
                          initialValue: _pickedTypeOfService,
                          sourcesDropdown: this.serviceType,
                          textLabel: kTypeOfService,
                          textError: "Required",
                          isRequired: true,
                          textKey: kTypeOfServiceKey,
                          onChangedValue: (value) {
                            setState(() {
                              print("Selected > Type Of Service : $value");
    
                              resetLeakWasFoundPickedValues();
                              if (value == null) {
                                // Reset the was leak found part to avoid confusion in UI
                                _wasLeakFound = null;
                                _wasLeakFound = false;
                                _pickedTypeOfService = value;
                              } else {
                                if (value is DropdownItem) {
                                  print(
                                      "Selected > Type Of Service (ID) : ${value
                                          .id}");
                                  this._filteredInitialLocationLeakFound = [];
                                  this._filteredVerificationLocationLeakFound =
                                  [];
                                  _pickedTypeOfService = value;
                                  switch (value.id) {
                                    case 2:
                                      {
                                        this.typeOfService =
                                            ServiceType.LeakInspection;
                                      }
                                      break;
                                    case 3:
                                      {
                                        this.typeOfService =
                                            ServiceType.ServiceAndLeakRepair;
                                      }
                                      break;
                                    case 5:
                                      {
                                        this.typeOfService =
                                            ServiceType.Shutdown;
                                      }
                                      break;
                                    default:
                                      {
                                        this.typeOfService = ServiceType.None;
                                      }
                                      break;
                                  }
                                }
                              }
                            });
                          },
                        ),
                      ]),
                      Row(children: <Widget>[
                        (this.typeOfService == ServiceType.Shutdown) ? Container() :
                        AppCancellableTextField(
                            initialValue: _pickedLeakDetectionMethod,
                            sourcesDropdown: this.leakDetectionMethod,
                            textLabel: kLeakDetectionMethod,
                            textError: "Required",
                            isRequired: true,
                            textKey: kLeakDetectionMethodKey,
                            onChangedValue: (value) {
                              _pickedLeakDetectionMethod = value;
                            }),
                      ]),
                      Row(children: <Widget>[
                        AppCancellableTextField(
                            initialValue: _wasLeakFound,
                            sourcesDropdown: this.wasLeakFound,
                            textLabel: kWasLeakFound,
                            textError:
                            "No Was Leak Found value found for service event",
                            isRequired: true,
                            textKey: kWasLeakFoundKey,
                            onChangedValue: (dropdown) {
                              print("Was leak found selected > $dropdown");
                              _wasLeakFound = null;
                              setState(() {
                                if (dropdown is DropdownItem) {
                                  if (dropdown.name == "Yes") {
                                    _wasLeakFound = true;
                                  } else if (dropdown.name == "No") {
                                    _wasLeakFound = false;
                                  }
                                }
                              });
                            })
                      ]),
                      Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                        FormBuild.buildDatePicker(
                            onValidated: (value) {
                              if (_pickedServiceDate == null)
                                return "No service date found for service event";
                              if (_pickedServiceDate.isAfter(DateTime.now()))
                                return "Future service date found for service event";
                            },
                            onPressed: (value) {
                              print(
                                  "$kServiceDateKey buildDatePicker > onPressed is $value");
                              _pickedServiceDate = value;
                            },
                            key: Key(kServiceDateKey),
                            helper: kServiceDate),
                      ]),
                      //  === PART === Second part of the form
                      _buildInspection(_wasLeakFound, this.typeOfService,
                          verificationLeakFound: _wasVerificationLeakFound),
                      (_pickedEquipmentWorkedOn != null)
                          ? _buildMaterialTransfer(this.typeOfService)
                          : Container(),
                      //  === PART === Submit
                      // This is for giving some space for the bottom button 'SUBMIT'
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                                onSaved: (value) {
                                  _pickedObservationNotes = value;
                                },
                                validator: (value) {
                                  if (_pickedTypeOfService.id == 3 ||
                                      _pickedTypeOfService.id == 5) {
                                    if (value.isEmpty)
                                      return "No repair notes found for service event with asset ID";
    //                                if (_pickedServiceAction.id == 9 &&
    //                                    value.length <= 30) {
    //                                  return "Repair notes must be at least 30 characters if service action Other is selected for service event";
    //                                }
                                  }
                                },
                                key: Key(kObservationNotesKey),
                                maxLength: 50,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  helperText: kObservationNotes,
                                  fillColor: Colors.black.withAlpha(6),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide:
                                      BorderSide(color: Colors.blue)),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      bottom: 10.0, left: 10.0, right: 10.0),
                                ),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: AppButton(
                              keyButton: Key(kSubmitButtonKey),
                              titleButton: kSubmitButton,
                              onPressed: () {
                                print(
                                    "Submit _pickedEquipmentWorkedOn : $_pickedEquipmentWorkedOn");
                                print(
                                    "Submit _pickedEstimatedLeakAmount : $_pickedEstimatedLeakAmount");
    
                                print("Submit Button was pressed by Arnaud");
                                if (_formKey.currentState.validate()) {
                                  print("> validate");
                                  _formKey.currentState.save();
                                  print("> saved");
                                  print("> $typeOfService");
                                  if (typeOfService == ServiceType.Shutdown) {
                                    submitShutdown().then((succeeded) {
                                      FormBuild.showFlushBarMessage(context,
                                          kAddServiceEventSuccessfulMessage, () {
                                            Navigator.of(context).pop();
                                          });
                                    }).catchError((error) {
                                      FormBuild.showFlushBarMessage(
                                          context, error, () {});
                                    });
                                  }
                                  else if (typeOfService ==
                                      ServiceType.ServiceAndLeakRepair) {
                                    submitServiceAndLeakRepair().then((succeeded) {
                                      FormBuild.showFlushBarMessage(context,
                                          kAddServiceEventSuccessfulMessage, () {
                                            Navigator.of(context).pop();
                                          });
                                    }).catchError((error) {
                                      FormBuild.showFlushBarMessage(
                                          context, error, () {});
                                    });
                                  }
                                  else if (typeOfService ==
                                      ServiceType.LeakInspection) {
                                    submitLeakInspection().then((succeeded) {
                                      FormBuild.showFlushBarMessage(context,
                                          kAddServiceEventSuccessfulMessage, () {
                                            Navigator.of(context).pop();
                                          });
                                    }).catchError((error) {
                                      print("submitLeakInspection > Error $error");
                                      FormBuild.showFlushBarMessage(
                                          context, error, () {});
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  );
        return Scaffold(
          key: key,
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white.withOpacity(0.0),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
                child: (_isDropdownsLoaded == false)
                    ? FormBuild.buildLoader()
                    : Form(
                  key: _formKey,
                  child: addServiceEventListView,
            )),
      ),
    );
  }
}

