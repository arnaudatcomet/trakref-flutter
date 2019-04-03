import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:async/async.dart';

enum ServiceType { LeakInspection, ServiceAndLeakRepair, Shutdown, None }

class PageServiceEventAddBloc extends StatefulWidget {
  @override
  _PageServiceEventAddBlocState createState() =>
      _PageServiceEventAddBlocState();
}

class _PageServiceEventAddBlocState extends State<PageServiceEventAddBloc> {
  List<Dropdown> locations;

  // Need to check what it is in the dropdown API
// List<Dropdown> temperatureClass;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  DropdownService service = DropdownService();
  bool _isDropdownsLoaded = false;
  DateTime _date = DateTime.now();
  ServiceType typeOfService = ServiceType.None;

  List<Dropdown> serviceType = [
    Dropdown(name: 'Leak Inspection', id: 2),
    Dropdown(name: 'Service and Leak Repair', id: 3),
    Dropdown(name: 'Shutdown', id: 5)
  ];

  List<Dropdown> wasLeakFound = [
    Dropdown(name: 'Yes', id: 1),
    Dropdown(name: 'No', id: 0)
  ];

  List<Dropdown> assets = [
    Dropdown(name: 'Electricity Meter 1', id: 1000018),
    Dropdown(name: '528 RDD Multi Temp', id: 1000022),
    Dropdown(name: 'Virgin R-408a lbs. 1000 457474', id: 1000026),
    Dropdown(name: 'Virgin R-404A lbs. 100 234567', id: 1000027),
    Dropdown(name: 'Virgin R-449A lbs. 115 12312211', id: 1000038),
    Dropdown(name: 'MR718', id: 1000055)
  ];

  List<LeakLocationDropdown> initialLocationLeakFound;
  List<LeakLocationDropdown> verificationLocationLeakFound;
  List<Dropdown> _filteredInitialLocationLeakFound;
  List<Dropdown> _filteredVerificationLocationLeakFound;
  List<Dropdown> categoriesLeakFound;
  List<Dropdown> categoryLocationLeakFound;
  List<Dropdown> causeOfLeaks;
  List<Dropdown> leakDetectionMethod;
  List<Dropdown> serviceActions;
  List<Dropdown> leakRepairStatus;
  List<Dropdown> shutdownStatus = [
    Dropdown(name: 'Shutdown', id: 6),
    Dropdown(name: 'Mothball', id: 2),
    Dropdown(name: 'Pending Install', id: 12),
  ];

  // UI Control variables
  bool _wasLeakFound = false;
  bool _wasVerificationLeakFound = false;

  // Form values
  Dropdown _pickedEquipmentWorkedOn = null;
  Dropdown _pickedTypeOfService = null;
  Dropdown _pickedLeakDetectionMethod = null;
  Dropdown _pickedWasLeakFound = null;
  DateTime _pickedServiceDate = null;
  Dropdown _pickedInitialLeakCategory = null;
  Dropdown _pickedInitialLeakLocation = null;
  Dropdown _pickedVerificationLeakCategory = null;
  Dropdown _pickedVerificationLeakLocation = null;
  Dropdown _pickedEstimatedLeakAmount = null;
  DateTime _pickedFollowUpDate = null;
  String _pickedObservationNotes = null;

  @override
  void initState() {
    super.initState();
    service.loadDropdowns();
    _isDropdownsLoaded = false;
    service.onLoaded = () {
      setState(() {
        this.initialLocationLeakFound = service.dropdowns.leakLocations;
        this.verificationLocationLeakFound = service.dropdowns.leakLocations;
        this.categoriesLeakFound = service.dropdowns.leakLocationCategories;
        this.causeOfLeaks = service.dropdowns.causeOfLeaks;
        this.leakDetectionMethod = service.dropdowns.leakDetectionMethods;
        this.serviceActions = service.dropdowns.serviceActions;
        this.leakRepairStatus = service.dropdowns.leakRepairStatuses;

        print("test of the first dropdwon : ${this.causeOfLeaks.first}");
        _isDropdownsLoaded = true;
      });
    };
  }

  // Build Vacuum dept dynamically
  List<Dropdown> _buildDropdownInt(int from, int length) {
    List<Dropdown> intList = List<Dropdown>();
    for (var i = from; i <= (from + length); i++) {
      intList.add(Dropdown(name: '$i', id: i));
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
    print("===> buildTitle for $type");
    if (type == ServiceType.None) {
      return Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                "Add Service Event",
                style: Theme.of(context).textTheme.title,
              ))
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
          children: <Widget>[
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    isRequired: true,
                    source: this.categoriesLeakFound,
                    key: Key(kInitialLeakCategoryKey),
                    label: kInitialLeakCategory,
                    onSaved: (value) {
                      _pickedInitialLeakCategory = value;
                    },
                    onChangedValue: (value) {
                      setState(() {
                        this._filteredInitialLocationLeakFound = null;
                      });
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (value is Dropdown) {
                          // Get the filtered leak location category
                          List<LeakLocationDropdown> selectedLeakLocationList =
                              this
                                  .initialLocationLeakFound
                                  .where((i) => i.categoryID == value.id)
                                  .toList();
                          List<Dropdown> categoryLeaksLocation =
                              selectedLeakLocationList
                                  .map((i) => Dropdown(id: i.id, name: i.name))
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
                        key: Key(kInitialLeakLocationKey),
                        isRequired: true,
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
                    source: this.causeOfLeaks,
                    key: Key(kCauseOfLeakKey),
                    label: kCauseOfLeak)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildTextField(
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
                    onPressed: (value) => print("$kFollowUpDateKey > onPressed is $value"),
                    onSaved: (value) {
                      print("$kFollowUpDateKey > $value");
                    }
                )
              ],
            )
          ],
        );
      } else if (type == ServiceType.ServiceAndLeakRepair) {
        print("===> ServiceAndLeakRepair");
        return Column(
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
                        if (value is Dropdown) {
                          // Get the filtered leak location category
                          List<LeakLocationDropdown> selectedLeakLocationList =
                              this
                                  .initialLocationLeakFound
                                  .where((i) => i.categoryID == value.id)
                                  .toList();
                          List<Dropdown> categoryLeaksLocation =
                              selectedLeakLocationList
                                  .map((i) => Dropdown(id: i.id, name: i.name))
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
                    key: Key(kServiceActionKey),
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
                      if (value is Dropdown) {
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
                              if (value is Dropdown) {
                                // Get the filtered leak location category
                                List<LeakLocationDropdown>
                                    selectedLeakLocationList = this
                                        .verificationLocationLeakFound
                                        .where((i) => i.categoryID == value.id)
                                        .toList();
                                List<Dropdown> categoryLeaksLocation =
                                    selectedLeakLocationList
                                        .map((i) =>
                                            Dropdown(id: i.id, name: i.name))
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
          children: <Widget>[
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    isRequired: true,
                    source: this.wasLeakFound,
                    key: Key(kWasVacuumPulledKey),
                    label: kWasVacuumPulled)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    isRequired: true,
                    source: _buildDropdownInt(0, 31),
                    key: Key(kDepthOfVacuumKey),
                    label: kDepthOfVacuum)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
                    isRequired: true,
                    source: this.serviceActions,
                    key: Key(kServiceActionKey),
                    label: kServiceAction)
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(
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
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.0),
          leading: IconButton(
              icon: Icon(
                Icons.close,
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
                              source: this.assets,
                              isRequired: true,
                              onSaved: (value) {
                                _pickedEquipmentWorkedOn = value;
                              },
                              onValidator: (value) {
                                if (value == null) {
                                  return 'Required';
                                }
                              },
                              label: kEquipmentWorkedOn,
                              key: Key(kEquipmentWorkedOnKey))
                        ]),
                        Row(children: <Widget>[
                          FormBuild.buildDropdown(
                              source: this.serviceType,
                              isRequired: true,
                              key: Key(kTypeOfServiceKey),
                              label: kTypeOfService,
                              onSaved: (value) {
                                _pickedTypeOfService = value;
                              },
                              onChangedValue: (value) {
                                setState(() {
                                  print("Selected > Type Of Service : $value");
                                  if (value is Dropdown) {
                                    this._filteredInitialLocationLeakFound = [];
                                    this._filteredVerificationLocationLeakFound =
                                        [];

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
                              isRequired: true,
                              source: this.leakDetectionMethod,
                              key: Key(kLeakDetectionMethodKey),
                              label: kLeakDetectionMethod),
                        ]),
                        Row(children: <Widget>[
                          FormBuild.buildDropdown(
                              onSaved: (value) {
                                _pickedWasLeakFound = value;
                              },
                              isRequired: true,
                              source: this.wasLeakFound,
                              key: Key(kWasLeakFoundKey),
                              label: kWasLeakFound,
                              onChangedValue: (dropdown) {
                                setState(() {
                                  if (dropdown is Dropdown) {
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
                              onPressed: (value) {
                                print("$kServiceDateKey buildDatePicker > onPressed is $value");
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
                                   print("$kObservationNotesKey > onSaved");
                                 },
                                  validator: (value) {
                                    if (value.isEmpty) return "Observation is required";
//                                    if (value.length < 50) return "Observation must be over 50 characters";
                                  },
                                  onFieldSubmitted: (value) {
                                    print("$kObservationNotesKey > onFieldSubmitted");
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
                                  print("This was pressed by Arnaud");
                                  if (_formKey.currentState.validate()) {
                                    print("> validate");
                                    _formKey.currentState.save();

                                    if (typeOfService == ServiceType.LeakInspection) {
                                      String equipmentWorkedOn = _pickedEquipmentWorkedOn.name;
                                      String typeOfService = _pickedTypeOfService.name;
                                      String leakDetectionMethod = _pickedLeakDetectionMethod.name;
                                      String wasLeakFound = _pickedWasLeakFound.name;
                                      String serviceDate = null;
                                      if (_pickedServiceDate != null ) {
                                        serviceDate = DateFormat('yyyy-MM-dd').format(_pickedServiceDate);
                                      }
                                      String notes = _pickedObservationNotes;

                                      print("equipmentWorkedOn $equipmentWorkedOn");
                                      print("typeOfService $typeOfService");
                                      print("leakDetectionMethod $leakDetectionMethod");
                                      print("wasLeakFound $wasLeakFound");
                                      print("serviceDate $serviceDate");
                                      print("notes $notes");
                                    }
                                  }
                                },
                              ),
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
