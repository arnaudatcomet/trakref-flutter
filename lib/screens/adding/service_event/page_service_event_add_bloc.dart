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
  bool _wasLeakFound = false;
  bool _wasVerificationLeakFound = false;

  // Current workOrder being constructed
  WorkOrder order = WorkOrder(
      id: 1071647,
      workOrderNumber: "790345789",
      instanceID: 248,
      locationID: 10721,
      workOrderTypeID: 2,
      workOrderStatusID: 1
  );

  // Form values
  DropdownItem _pickedEquipmentWorkedOn = null;
  DropdownItem _pickedTypeOfService = null;
  DropdownItem _pickedLeakDetectionMethod = null;
  DropdownItem _pickedWasLeakFound = null;
  DateTime _pickedServiceDate = null;
  DropdownItem _pickedCauseOfLeak = null;
  double _pickedEstimatedLeakAmount = null;
  DropdownItem _pickedInitialLeakCategory = null;
  DropdownItem _pickedInitialLeakLocation = null;
  DropdownItem _pickedVerificationLeakCategory = null;
  DropdownItem _pickedVerificationLeakLocation = null;
  DropdownItem _pickedWasVacuumPulled = null;
  DropdownItem _pickedDepthOfVacuum = null;
  DropdownItem _pickedServiceAction = null;
  DropdownItem _pickedShutdownStatus = null;
  DateTime _pickedFollowUpDate = null;
  String _pickedObservationNotes = null;

  double _pickedTest = null;

  Language selectedLanguage = null;

  List<Language> listLanguage = <Language>[
    new Language("English", "en"),
    new Language("French", "fr"),
    new Language("Hindi", "hi"),
  ];

  @override
  void initState() {
    super.initState();
    _isDropdownsLoaded = false;
    TrakrefAPIService().getDropdown().then((results){
      setState(() {
        this.initialLocationLeakFound = results.leakLocations;
        this.verificationLocationLeakFound = results.leakLocations;
        this.categoriesLeakFound = results.leakLocationCategories;
        this.causeOfLeaks = results.causeOfLeaks;
        this.leakDetectionMethod = results.leakDetectionMethods;

        this.serviceActions = results.serviceActions;
        this.leakRepairStatus = results.leakRepairStatuses;
        _isDropdownsLoaded = true;

        // Map the list of assets to a dropdown sources
        assetsDropdowns = (widget.assets ?? []).map((i) {
          return DropdownItem(
              name: i.name,
              id: i.assetID
          );
        }).toList();

      });
    });
//    service.loadDropdowns();
//    _isDropdownsLoaded = false;
//    service.onLoaded = () {
//    };
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

//    scaffoldKey.currentState.showSnackBar(
//      SnackBar(content: Text("Your service event was added"))
//    );

//    await new Future.delayed(const Duration(seconds:2));
//    Navigator.of(context).pop();
//    Navigator.push(context, new MaterialPageRoute(builder: (__) => new SecondView()));

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
                        onChangedValue: (value) {
                          _pickedInitialLeakLocation = value;
                        },
                        key: Key(kInitialLeakLocationKey),
                        isRequired: true,
                        onValidator: (value) {
                          if (_pickedInitialLeakLocation == null) return "Required";
                        },
                        source: this._filteredInitialLocationLeakFound,
                        label: kInitialLeakLocation,
                      )
                    ],
                  )
                : Container(),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    isRequired: true,
                    onValidator: (value) {
                    },
                    onChangedValue: (value) {
                      _pickedCauseOfLeak = value;
                    },
                    source: this.causeOfLeaks,
                    key: Key(kCauseOfLeakKey),
                    label: kCauseOfLeak)
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
                      print("TextField onSubmitted : $_pickedTest");
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
                FormBuild.buildDropdown(
                    onValidator: (value) {
                      if (_pickedWasVacuumPulled == null)
                        return "No value for WasProperVacuumPulled found for shutdown service event";
                    },
                    onChangedValue: (value) {
                      _pickedWasVacuumPulled = value;
                    },
                    isRequired: true,
                    source: this.wasLeakFound,
                    key: Key(kWasVacuumPulledKey),
                    label: kWasVacuumPulled),
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    onChangedValue: (value) {
                      _pickedDepthOfVacuum = value;
                    },
                    isRequired: false,
                    source: depthVacuumAmount,
                    key: Key(kDepthOfVacuumKey),
                    label: kDepthOfVacuum)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    onSaved: (value) {
                      _pickedServiceAction = value;
                    },
                    isRequired: true,
                    source: this.serviceActions,
                    key: Key(kShutdownServiceActionKey),
                    label: kServiceAction)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    onSaved: (value) {
                      _pickedShutdownStatus = value;
                    },
                    isRequired: true,
                    source: this.shutdownStatus,
                    key: Key(kPostShutdownStatusKey),
                    label: kPostShutdownStatus)
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
                          FormBuild.buildDropdown(
                              label: kEquipmentWorkedOn,
                              key: Key(kEquipmentWorkedOnKey),
                              initialValue: _pickedEquipmentWorkedOn,
                              source:this.assetsDropdowns,
                              isRequired: true,
                              onChangedValue: (value) {
                                print(
                                    "$kEquipmentWorkedOn > onChangedValue : $value");
                                _pickedEquipmentWorkedOn = value;
                              },
                              onValidator: (value) {
                                if (_pickedEquipmentWorkedOn == null) return "Required";
                              })
                        ]),
                        Row(children: <Widget>[
                          FormBuild.buildDropdown(
                              source: this.serviceType,
                              isRequired: true,
                              key: Key(kTypeOfServiceKey),
                              label: kTypeOfService,
                              initialValue: _pickedTypeOfService,
                              onSaved: (value) {
                                _pickedTypeOfService = value;
                              },
                              onValidator: (value) {
                                if (_pickedTypeOfService == null)
                                  return "Required";
                              },
                              onChangedValue: (value) {
                                setState(() {
                                  print("Selected > Type Of Service : $value");
                                  if (value is DropdownItem) {
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
                                });
                              })
                        ]),
                        Row(children: <Widget>[
                          FormBuild.buildDropdown(
                              onSaved: (value) {
                                _pickedLeakDetectionMethod = value;
                              },
                              onValidator: (value) {
                                if (_pickedLeakDetectionMethod == null)
                                  return "Invalid asset ID found for service event";
                              },
                              onChangedValue: (value) {
                                _pickedLeakDetectionMethod = value;
                              },
                              isRequired: true,
                              source: this.leakDetectionMethod,
                              key: Key(kLeakDetectionMethodKey),
                              label: kLeakDetectionMethod),
                        ]),
                        Row(children: <Widget>[
                          FormBuild.buildDropdown(
                              onValidator: (value) {
                                if (_wasLeakFound == null)
                                  return "No Was Leak Found value found for service event";
                              },
                              isRequired: true,
                              source: this.wasLeakFound,
                              key: Key(kWasLeakFoundKey),
                              label: kWasLeakFound,
                              onChangedValue: (dropdown) {
                                setState(() {
                                  if (dropdown is DropdownItem) {
                                    print(
                                        "Was leak found selected > ${dropdown.name}");
                                    if (dropdown.name == "Yes") {
                                      _wasLeakFound = true;
                                    } else {
                                      _wasLeakFound = false;
                                    }
                                  }
                                });
                              })
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
                                  Asset selectedAsset = Asset(
                                      assetID: _pickedEquipmentWorkedOn.id
                                  );
                                  int pickedIndex = widget.assets.indexOf(
                                      selectedAsset);

                                  Navigator.of(context).push(
                                      SlideRightRoute(
                                          widget: PageMaterialGasInstallBloc(
                                            installType: MaterialGasInstallType.Recovery,
                                            currentAssetWorkedOn: widget
                                                .assets[pickedIndex],
                                            assets: widget.assets,
                                          )
                                      )
                                  );
                                  return;

                                  if (_pickedEquipmentWorkedOn?.id != null && _pickedEquipmentWorkedOn?.id > -1) {
                                    print("_pickedEquipmentWorkedOn.id : ${_pickedEquipmentWorkedOn
                                        .id}");
                                    Asset selectedAsset = Asset(
                                        assetID: (_pickedEquipmentWorkedOn is Dropdown) ? _pickedEquipmentWorkedOn.id : 0);
                                    int pickedIndex = widget.assets.indexOf(
                                        selectedAsset);
                                    print("selectedAsset.id : ${widget.assets[pickedIndex]}");

                                  }

//                                  print("Submit Button was pressed by Arnaud");
//                                  if (_formKey.currentState.validate()) {
//                                    print("> validate");
//                                    _formKey.currentState.save();
//                                    print("> saved");
//
//                                    if (typeOfService ==
//                                        ServiceType.LeakInspection) {
//                                      submitLeakInspection(_wasLeakFound, key);
//                                    } else if (typeOfService ==
//                                        ServiceType.Shutdown) {}
//                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
      ),
    );
  }
}
