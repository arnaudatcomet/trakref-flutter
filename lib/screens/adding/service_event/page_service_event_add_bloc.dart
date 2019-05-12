import "package:flutter/material.dart";
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/screens/page_material_gas_install_bloc.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:intl/intl.dart';

// 2, 3, 5, 0
enum ServiceType { LeakInspection, ServiceAndLeakRepair, Shutdown, None }

class PageServiceEventAddBloc extends StatefulWidget {
  List<Asset> assets = [];
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
//  DropdownService service = DropdownService();
  bool _isDropdownsLoaded = false;
  DateTime _date = DateTime.now();
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
  DropdownItem _pickedWasLeakFound;
  DateTime _pickedServiceDate;
  DropdownItem _pickedCauseOfLeak;
  double _pickedEstimatedLeakAmount;
  DropdownItem _pickedInitialLeakCategory;
  DropdownItem _pickedInitialLeakLocation;
  DropdownItem _pickedVerificationLeakCategory;
  DropdownItem _pickedVerificationLeakLocation;
  DropdownItem _pickedWasVacuumPulled;
  DropdownItem _pickedDepthOfVacuum;
  DropdownItem _pickedServiceAction;
  DropdownItem _pickedShutdownStatus;
  DateTime _pickedFollowUpDate;
  String _pickedObservationNotes;

  @override
  void initState() {
    super.initState();
    _isDropdownsLoaded = false;
    TrakrefAPIService().getDropdown().then((results){

      print("AssetDropdowns ${widget.assets}");
      // Map the list of assets to a dropdown sources
      setState(() {
        assetsDropdowns = (widget.assets ?? []).map((i) {
          return DropdownItem(
              name: i.name,
              id: i.assetID
          );
        }).toList();

        this.initialLocationLeakFound = results.leakLocations;
        this.verificationLocationLeakFound = results.leakLocations;
        this.categoriesLeakFound = results.leakLocationCategories;
        this.causeOfLeaks = results.causeOfLeaks;
        this.leakDetectionMethod = results.leakDetectionMethods;

        this.serviceActions = results.serviceActions;
        this.leakRepairStatus = results.leakRepairStatuses;
        _isDropdownsLoaded = true;
      });
    });
  }

  void resetPickedValues() {
    _pickedEquipmentWorkedOn = null;
    _pickedTypeOfService = null;
    _pickedLeakDetectionMethod = null;
    _pickedServiceDate = null;
    resetLeakWasFoundPickedValues();
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
    _pickedShutdownStatus = null;
    _pickedFollowUpDate = null;
    _pickedObservationNotes = null;
    _pickedWasLeakFound = null;
  }

  // Submit Service Event - Leak Inspection
  Future<bool> submitLeakInspection(bool leakFound, GlobalKey<ScaffoldState> scaffoldKey) async {
    // Retrieve the values
    int equipmentWorkedOn =
        _pickedEquipmentWorkedOn.id;
    String typeOfService =
        _pickedTypeOfService.name;
    String leakDetectionMethod =
        _pickedLeakDetectionMethod.name;
    String wasLeakFound =
        _pickedWasLeakFound.name;
    String serviceDate = null;
    if (_pickedServiceDate != null) {
      serviceDate = DateFormat(kShortDateFormat)
          .format(_pickedServiceDate);
    }
    String notes = _pickedObservationNotes;

    // If we found a leak
    List<LeakInspection> leakInspections = [];
    if (leakFound == true) {
      // Values from the forms
      int leakCategory = _pickedInitialLeakCategory.id;
      int leakLocation = _pickedInitialLeakLocation.id;
      int causeLeak = _pickedCauseOfLeak.id;
      double estimatedLeakAmount = _pickedEstimatedLeakAmount.toDouble();
      String followUpDateString;
      if (_pickedFollowUpDate != null) {
        followUpDateString = DateFormat(kShortDateFormat).format(_pickedFollowUpDate);
        print("followUpDate $followUpDateString");
      }

      LeakInspection inspection = LeakInspection(
        leakLocationCategoryID: leakCategory,
        leakLocationID: leakLocation,
        faultCauseTypeID: causeLeak,
        estimatedLeakAmount: estimatedLeakAmount,
        inspectionDate: followUpDateString
      );

      leakInspections = [inspection];
    }

    // Create the WorkOrder and Submit it
    // For the sake of purpose we don't touch the Work Order part, only the service event part
    widget.currentWorkOrder.workItem = [
      WorkItem(
          wasLeakFound: leakFound,
          assetID: equipmentWorkedOn,
          workItemTypeID: 2,
          // It's invalid if WorkItem type != 3, 2 and 5
          serviceDate: serviceDate,
          workItemStatusID: 1,
          // Repair
          repairNotes: notes,
          leakInspectionCount: (leakFound == false) ? 0 : 1,
          leakInspection: (leakFound == false) ? [] : leakInspections
      )
    ];
    widget.currentWorkOrder.workItemCount = 1;
//    WorkOrder workOrder = WorkOrder(
//        id: 1071647,
//        workOrderNumber: "790345789",
//        instanceID: 248,
//        locationID: 10721,
//        workOrderTypeID: 2,
//        workOrderStatusID: 1,
//        workItem: [
//          WorkItem(
//              wasLeakFound: leakFound,
//              assetID: equipmentWorkedOn,
//              workItemTypeID: 2, // It's invalid if WorkItem type != 3, 2 and 5
//              serviceDate: serviceDate,
//              workItemStatusID: 1,
//              // Repair
//              repairNotes: notes,
//              leakInspectionCount: (leakFound == false) ? 0 : 1,
//              leakInspection: (leakFound == false) ? [] : leakInspections
//          )
//        ]
//    );

    setState(() {
      _isDropdownsLoaded = false;
    });
    await new Future.delayed(const Duration(seconds:2));
//    var response = await ApiService().postWorkOrder(workOrder, "https://api.trakref.com/v3.21/WorkOrders");
//    print("Response from POST Service event : $response");

    setState(() {
      _isDropdownsLoaded = true;
    });
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
                style: Theme.of(context).textTheme.title,
              )
          ),
          (type == ServiceType.None) ? Container() : Expanded(
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
                style: Theme.of(context).textTheme.title,
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

  Widget _buildVerificationChip() {
    return Chip(
      backgroundColor: AppColors.lightGreen,
      label: Text('Verification',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
                      setState(() {
                      });
                    }),
              ],
            ),
            (this._filteredInitialLocationLeakFound != null)
                ? Row(
              children: <Widget>[
                AppCancellableTextField(
                    initialValue: _pickedInitialLeakLocation,
                    sourcesDropdown: this._filteredInitialLocationLeakFound,
                    textKey: kInitialLeakLocationKey,
                    textLabel: kInitialLeakLocation,
                    textError: "Required",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedInitialLeakLocation = value;
                    }
                )
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
                    }
                )
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildTextField(
                    onValidated: (value) {
                      print("Textfield ${Key(kEstimatedLeakAmountKey)} is being validated with value '$value'");
                      if (value.isEmpty || value == null) {
                        return "Required";
                      }
                    },
                    onSubmitted: (value) {
                      double estimatedLeakAmount = double.parse(value);
                      if (estimatedLeakAmount != null) {
                        _pickedEstimatedLeakAmount = estimatedLeakAmount;
                      }
                    },
                    key: Key(kEstimatedLeakAmountKey),
                    label: kEstimatedLeakAmount,
                    inputType: TextInputType.number)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDatePicker(
                    key: Key(kFollowUpDateKey),
                    helper: kFollowUpDate,
                    onPressed: (value) => _pickedFollowUpDate = value)
              ],
            )
          ],
        );
      }
      else if (type == ServiceType.ServiceAndLeakRepair) {
        print("===> ServiceAndLeakRepair");
        return Column(
          key: Key("kbuildServiceAndLeakRepair"),
          children: <Widget>[
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    isRequired: true,
                    source: this.categoriesLeakFound,
                    key: Key(kInitialLeakCategoryKey),
                    label: kInitialLeakCategory,
                    onChangedValue: (value) {
                      setState(() {
                        this._filteredInitialLocationLeakFound = null;
                      });
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (value is DropdownItem) {
                          // Get the filtered leak location category
                          List<LeakLocationItem> selectedLeakLocationList =
                              this
                                  .initialLocationLeakFound
                                  .where((i) => i.categoryID == value.id)
                                  .toList();
                          List<DropdownItem> categoryLeaksLocation =
                              selectedLeakLocationList
                                  .map((i) => DropdownItem(id: i.id, name: i.name))
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
                      // Need to change that
                      FormBuild.buildDropdown(
                          isRequired: true,
                          source: this._filteredInitialLocationLeakFound,
                          label: kInitialLeakLocation,
                          key: Key(kInitialLeakLocationKey))
                    ],
                  )
                : Container(),
            Row(
              children: <Widget>[
                // Need to change that
                FormBuild.buildDropdown(
                    onValidator: (value) {
                      if (_pickedTypeOfService.id == 3 ||
                          _pickedTypeOfService.id == 5) {
                        if (_pickedCauseOfLeak.id == null) {
                          return "Cause of Leak required since WasLeakFound was clicked for leak inspection service event";
                        }
                      }
                    },
                    onChangedValue: (value) {
                      _pickedCauseOfLeak = value;
                    },
                    isRequired: true,
                    source: this.causeOfLeaks,
                    key: Key(kCauseOfLeakKey),
                    label: kCauseOfLeak)
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
                // Need to change that
                FormBuild.buildDropdown(
                    source: this.serviceActions,
                    isRequired: true,
                    key: Key(kServiceAndLeakRepairServiceActionKey),
                    label: kServiceAction)
              ],
            ),
            // URGENT: Need to add material gas
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    source: this.leakRepairStatus,
                    isRequired: true,
                    key: Key(kLeakRepairStatusKey),
                    label: kLeakRepairStatus)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDatePicker(
                    key: Key(kVerificationDateKey), helper: kVerificationDate)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    source: this.leakDetectionMethod,
                    isRequired: true,
                    key: Key(kVerificationLeakMethodKey),
                    label: kVerificationLeakMethod)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    source: this.wasLeakFound,
                    key: Key(kVerificationWasLeakFoundKey),
                    isRequired: true,
                    label: kVerificationWasLeakFound,
                    onChangedValue: (value) {
                      if (value is DropdownItem) {
                        setState(() {
                          this._filteredVerificationLocationLeakFound = [];
                          if (value.name == "Yes") {
                            _wasVerificationLeakFound = true;
                          } else {
                            _wasVerificationLeakFound = false;
                          }
                        });
                      }
                    })
              ],
            ),
            // Note : maybe a better way to do the UI below
            (_wasVerificationLeakFound)
                ? Row(
                    children: <Widget>[
                      FormBuild.buildDropdown(
                          source: this.causeOfLeaks,
                          isRequired: true,
                          key: Key(kVerificationLeakCauseKey),
                          label: kVerificationLeakCause),
                      _buildVerificationChip()
                    ],
                  )
                : Container(),
            (_wasVerificationLeakFound)
                ? Row(
                    children: <Widget>[
                      FormBuild.buildDropdown(
                          source: this.categoriesLeakFound,
                          isRequired: true,
                          key: Key(kVerificationLeakCategoryKey),
                          label: kVerificationLeakCategory,
                          onChangedValue: (value) {
                            setState(() {
                              this._filteredVerificationLocationLeakFound = [];
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
                                        DropdownItem(id: i.id, name: i.name))
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
                      _buildVerificationChip()
                    ],
                  )
                : Container(),
            (_wasVerificationLeakFound &&
                    this._filteredVerificationLocationLeakFound != null)
                ? Row(
                    children: <Widget>[
                      FormBuild.buildDropdown(
                          isRequired: true,
                          source: this._filteredVerificationLocationLeakFound,
                          key: Key(kVerificationLeakLocationKey),
                          label: kVerificationLeakLocation),
                      _buildVerificationChip()
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
                    textError: "No value for WasProperVacuumPulled found for shutdown service event",
                    isRequired: true,
                    onChangedValue: (value) {
                      _pickedWasVacuumPulled = value;
                    }
                ),
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
                    }
                )
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
                    }
                )
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
                    }
                )
              ],
            )
          ],
        );
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
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
        child: SafeArea(
            child: (_isDropdownsLoaded == false)
                ? FormBuild.buildLoader()
                : Form(
                    key: _formKey,
                    child: ListView(
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
                              }
                          ),
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
                                }
                                else {
                                  if (value is DropdownItem) {
                                    print("Selected > Type Of Service (ID) : ${value.id}");
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
                          AppCancellableTextField(
                              initialValue: _pickedLeakDetectionMethod,
                              sourcesDropdown: this.leakDetectionMethod,
                              textLabel: kLeakDetectionMethod,
                              textError: "Required",
                              isRequired: true,
                              textKey: kLeakDetectionMethodKey,
                              onChangedValue: (value) {
                                _pickedLeakDetectionMethod = value;
                              }
                          ),
                        ]),
                        Row(children: <Widget>[
                          AppCancellableTextField(
                              initialValue: _wasLeakFound,
                              sourcesDropdown: this.wasLeakFound,
                              textLabel: kWasLeakFound,
                              textError: "No Was Leak Found value found for service event",
                              isRequired: true,
                              textKey: kWasLeakFoundKey,
                              onChangedValue: (dropdown) {
                                print(
                                    "Was leak found selected > $dropdown");
                                _wasLeakFound = null;
                                setState(() {
                                  if (dropdown is DropdownItem) {
                                    if (dropdown.name == "Yes") {
                                      _wasLeakFound = true;
                                    } else if (dropdown.name == "No"){
                                      _wasLeakFound = false;
                                    }
                                  }
                                });
                              }
                          )
                        ]),
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                          FormBuild.buildDatePicker(
                              onValidated: (value) {
                                if (_pickedServiceDate == null) return "No service date found for service event";
                                if (_pickedServiceDate.isAfter(DateTime.now())) return "Future service date found for service event";
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
                                    if (_pickedTypeOfService.id == 3 || _pickedTypeOfService.id == 5) {
                                      if (value.isEmpty) return "No repair notes found for service event with asset ID";
                                      if (_pickedServiceAction.id == 9 && value.length <= 30) {
                                        return "Repair notes must be at least 30 characters if service action Other is selected for service event";
                                      }
                                    }
                                  },
                                  key: Key(kObservationNotesKey),
                                  maxLength: 50,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    helperText: kObservationNotes,
                                    fillColor: Colors.white,
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
//                                  Asset selectedAsset = Asset(
//                                      assetID: _pickedEquipmentWorkedOn.id
//                                  );
//                                  int pickedIndex = widget.assets.indexOf(
//                                      selectedAsset);
//
//                                  Navigator.of(context).push(
//                                      SlideRightRoute(
//                                          widget: PageMaterialGasInstallBloc(
//                                            installType: MaterialGasInstallType.Recovery,
//                                            currentAssetWorkedOn: widget
//                                                .assets[pickedIndex],
//                                            assets: widget.assets,
//                                          )
//                                      )
//                                  );
//                                  return;


                                  print("Submit _pickedEquipmentWorkedOn : ${_pickedEquipmentWorkedOn}");
                                  print("Submit Button was pressed by Arnaud");
                                  if (_formKey.currentState.validate()) {
                                    print("> validate");
                                    _formKey.currentState.save();
                                    print("> saved");

//                                    if (typeOfService ==
//                                        ServiceType.LeakInspection) {
//                                      submitLeakInspection(_wasLeakFound, key);
//                                    } else if (typeOfService ==
//                                        ServiceType.Shutdown) {}
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
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            OutlineAppButton(
//                              keyButton: Key('RestFormKey'),
//                              titleButton: "CLEAR FORM",
//                              onPressed: () {
//                                print("> RestFormKey");
//                                resetPickedValues();
//                                setState(() {
//                                });
//                              },
//                            )
//                          ],
//                        )
                      ],
                    ),
                  )),
      ),
    );
  }
}

typedef AppCancellableTextFieldDelegate = void Function(dynamic);

class AppCancellableTextField extends StatefulWidget {
  final Function onChangedValue;
  final String textLabel;
  final String textKey;
  final String textError;
  final bool isRequired;
  final List<dynamic> sourcesDropdown;
  final dynamic initialValue;

  AppCancellableTextField({this.initialValue, @required this.onChangedValue, @required this.textLabel, this.textError,
    @required this.textKey, this.isRequired, @required this.sourcesDropdown});

  @override
  _AppCancellableTextFieldState createState() => _AppCancellableTextFieldState();
}

class _AppCancellableTextFieldState extends State<AppCancellableTextField> {
  dynamic _pickedValue;
  
  void resetPickedValue() {
    _pickedValue = null;
  }

  @override
  void initState() {
    super.initState();
    _pickedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    print("AppCancellableTextField '${widget.textKey}' > Build : $_pickedValue");
    // Default it's not required
    bool isRequired = widget.isRequired ?? false;

    Widget selectedValue = Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check, color: AppColors.blueTurquoise, size: 14),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.textLabel, style: (isRequired == false) ? Theme.of(context).textTheme.display3 : Theme.of(context).textTheme.display3.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                (_pickedValue == null) ? "" : _pickedValue.toString(), style: Theme.of(context).textTheme.display2.copyWith(
                color: AppColors.blueTurquoise
              ),
              )
            ],
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent),
              onPressed: () {
                _pickedValue = null;
                setState(() {
                });
                widget.onChangedValue(_pickedValue);
              })
        ],
      ),
    );

    Widget toSelectDropdown = FormBuild.buildDropdown(
        label: widget.textLabel,
        key: Key(widget.textKey),
        source: widget.sourcesDropdown,
        isRequired: isRequired,
        onChangedValue: (value) {
          print("onChangedValue $value");
          if (value is DropdownItem) {
            print("onChangedValue id=${value.id}");
          }
          print("onChangedValue=${widget.onChangedValue}");
          _pickedValue = value;
          widget.onChangedValue(_pickedValue);
          setState(() {
          });
        },
        onValidator: (value) {
          if (widget.textError != null) {
            if (value == null) {
              return widget.textError;
            }
          }
        }
    );


    return (_pickedValue != null) ? selectedValue : toSelectDropdown ;
  }
}
