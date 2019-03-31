import "package:flutter/material.dart";
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:async/async.dart';

enum ServiceType { LeakInspection, ServiceAndLeakRepair, Shutdown, None }

class PageServiceEventAddBloc extends StatefulWidget {
  // Example dropdowns

  List<Dropdown> serviceType = [
    Dropdown(name: 'Leak Inspection', id: 2),
    Dropdown(name: 'Service and Leak Repair', id: 3),
    Dropdown(name: 'Shutdown', id: 5)
  ];

  List<Dropdown> wasLeakFound = [
    Dropdown(name: 'Yes', id: 1),
    Dropdown(name: 'No', id: 0)
  ];
  /*
  // For testing purposes
  List<Dropdown> assets = [
    Dropdown(name: 'Electricity Meter 1', id: 1000018),
    Dropdown(name: '528 RDD Multi Temp', id: 1000022),
    Dropdown(name: 'Virgin R-408a lbs. 1000 457474', id: 1000026),
    Dropdown(name: 'Virgin R-404A lbs. 100 234567', id: 1000027),
    Dropdown(name: 'Virgin R-449A lbs. 115 12312211', id: 1000038),
    Dropdown(name: 'MR718', id: 1000055)
  ];


  //Leaks location
  List<Dropdown> locationLeakFound = [
    Dropdown(name: 'Compressor', id: 2),
    Dropdown(name: 'Condenser', id: 3),
    Dropdown(name: 'Discharge Line', id: 5),
    Dropdown(name: 'Evaporator', id: 6),
    Dropdown(name: 'Heat Recovery', id: 7),
    Dropdown(name: 'Liquid Line', id: 8),
    Dropdown(name: 'Other', id: 9)
  ];

  // Cause of Leaks
  List<Dropdown> causeOfLeaks = [
    Dropdown(name: 'ALDS', id: 2),
    Dropdown(name: 'Abuse', id: 3),
    Dropdown(name: 'Catastrophe', id: 5),
    Dropdown(name: 'Corrosion', id: 6),
    Dropdown(name: 'Joint failure', id: 7),
    Dropdown(name: 'Mechanical failure ', id: 8),
    Dropdown(name: 'Normal water', id: 9)
  ];

  // Leak detection methods
  List<Dropdown> leakDetectionMethod = [
    Dropdown(name: 'ALD', id: 2),
    Dropdown(name: 'Alternative', id: 3),
    Dropdown(name: 'Bubble Test', id: 5),
    Dropdown(name: 'Dye Inject', id: 6)
  ];

  // Service Actions
  List<Dropdown> serviceActions = [
    Dropdown(name: 'Audit/Inspect', id: 2),
    Dropdown(name: 'Bypass', id: 3),
    Dropdown(name: 'Calibrate/Adjust', id: 5),
    Dropdown(name: 'New cap/seal', id: 6)
  ];

  // Leak repair status
  List<Dropdown> leakRepairStatus = [
    Dropdown(name: 'LeakRepaired', id: 2),
    Dropdown(name: 'NoRepair', id: 3),
    Dropdown(name: 'RepairAttempted', id: 5)
  ];

  // Post shutdown status
  List<Dropdown> shutdownStatus = [
    Dropdown(name: 'Mothball', id: 2),
    Dropdown(name: 'Pending Install', id: 3),
    Dropdown(name: 'Shutdown', id: 4),
  ];
  */

  List<Dropdown> assets = [
    Dropdown(name: 'Electricity Meter 1', id: 1000018),
    Dropdown(name: '528 RDD Multi Temp', id: 1000022),
    Dropdown(name: 'Virgin R-408a lbs. 1000 457474', id: 1000026),
    Dropdown(name: 'Virgin R-404A lbs. 100 234567', id: 1000027),
    Dropdown(name: 'Virgin R-449A lbs. 115 12312211', id: 1000038),
    Dropdown(name: 'MR718', id: 1000055)
  ];

  List<LeakLocationDropdown> locationLeakFound;
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

  @override
  _PageServiceEventAddBlocState createState() => _PageServiceEventAddBlocState();

}

class _PageServiceEventAddBlocState extends State<PageServiceEventAddBloc> {  List<Dropdown> locations;
  // Need to check what it is in the dropdown API
// List<Dropdown> temperatureClass;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  DropdownService service = DropdownService();
  bool _isDropdownsLoaded = false;
  DateTime _date = DateTime.now();
  ServiceType typeOfService = ServiceType.None;

  // UI Control variables
  bool _wasLeakFound = false;
  bool _wasVerificationLeakFound = false;

  @override
  void initState() {
    super.initState();
    service.loadDropdowns();
    _isDropdownsLoaded = false;
    service.onLoaded = () {
      setState(() {
        widget.locationLeakFound = service.dropdowns.leakLocations;
        widget.causeOfLeaks = service.dropdowns.causeOfLeaks;
        widget.leakDetectionMethod = service.dropdowns.leakDetectionMethods;
        widget.serviceActions = service.dropdowns.serviceActions;
        widget.leakRepairStatus = service.dropdowns.leakRepairStatuses;
        _isDropdownsLoaded = true;
      });
    };
  }


  // Build Vacuum dept dynamically
  List<Dropdown> _buildDropdownInt(int from, int length)
  {
    List<Dropdown> intList = List<Dropdown>();
    for(var i = from; i <= (from + length); i++){
      intList.add(Dropdown(name: '$i', id: i));
    }
    return intList;
  }

  String _getServiceTypeRaw(ServiceType type) {
    if (type == ServiceType.LeakInspection) {
      return "Leak Inspection";
    }
    else if (type == ServiceType.ServiceAndLeakRepair) {
      return "Service Repair";
    }
    else if (type == ServiceType.Shutdown) {
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
              child: Text("Add Service Event",
                style: Theme.of(context).textTheme.title,
              )
          )
        ],
      );
    }
    else {
      return Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text("Add Service Event",
                style: Theme.of(context).textTheme.title,
              )
          ),
          Expanded(
            flex:1,
            child: Chip(
              backgroundColor: AppColors.blueTurquoise,
              label: Text('${_getServiceTypeRaw(type)} ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      color: Colors.white
                  )
              ),
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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          )
      ),
    );
  }

  Widget _buildInspection(bool leakFound, ServiceType type, {bool verificationLeakFound}) {
    print("===> leakFound ? $leakFound, verification ? $verificationLeakFound, type ? $type");
    // Show leak inspection
    if (leakFound == true) {
      if (type == ServiceType.LeakInspection) {
        print("===> buildLeakInspection");
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.locationLeakFound, label: "Where was leak found? *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.causeOfLeaks, label: "Cause of leak *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildTextField(label: "Estimate leak amount")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDatePicker(key: Key("FollowUpDateKey"), helper: "Follow up date *")
              ],
            )
          ],
        );
      }
      else if (type == ServiceType.ServiceAndLeakRepair) {
        print("===> ServiceAndLeakRepair");
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.locationLeakFound, label: "Leak location *")
              ],
            ),
            Row(
              children: <Widget>[
                // Need to change that
                FormBuild.buildDropdown(source: widget.locationLeakFound, label: "Leak category *")
              ],
            ),
            Row(
              children: <Widget>[
                // Need to change that
                FormBuild.buildDropdown(source: widget.causeOfLeaks, label: "Cause of leak *")
              ],
            ),
            Row(
              children: <Widget>[
                // Need to change that
                FormBuild.buildTextField(label: "Estimated leak amount")
              ],
            ),
            Row(
              children: <Widget>[
                // Need to change that
                FormBuild.buildDropdown(source: widget.serviceActions, label: "Service action *")
              ],
            ),
            // URGENT: Need to add material gas
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.leakRepairStatus, label: "Leak repair status *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDatePicker(label: "Verification date *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.leakDetectionMethod,
                    label: "Verification leak method *"
                )
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.wasLeakFound,
                    label: "Was leak found during follow up inspection *",
                    onChangedValue: (value) {
                      if (value is Dropdown) {
                        setState(() {
                          if (value.name == "Yes") {
                            _wasVerificationLeakFound = true;
                          }
                          else {
                            _wasVerificationLeakFound = false;
                          }
                        });
                      }
                    })
              ],
            ),
            // Note : maybe a better way to do the UI below
            (_wasVerificationLeakFound) ? Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.causeOfLeaks, label: "Leak cause *"),
                _buildVerificationChip()
              ],
            ): Container(),
            (_wasVerificationLeakFound) ? Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.locationLeakFound, label: "Leak location *"),
                _buildVerificationChip()
              ],
            ): Container(),
            (_wasVerificationLeakFound) ? Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.locationLeakFound, label: "Leak category *"),
                _buildVerificationChip()
              ],
            ): Container()
          ],
        );
      }
      else if (type == ServiceType.Shutdown) {
        print("===> buildShutdown");
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.wasLeakFound, label: "Was vacuum pulled? *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: _buildDropdownInt(0, 31), label: "Depth of vacuum *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.serviceActions, label: "Service action *")
              ],
            ),
            Row(
              children: <Widget>[
                FormBuild.buildDropdown(source: widget.shutdownStatus, label: "Post shutdown status *")
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
        leading: IconButton(icon: Icon(
          Icons.close,
          color: Colors.black87,
        ), onPressed: (){
          Navigator.of(context).pop();
        })
      ),
      body: SafeArea(
        child: (_isDropdownsLoaded == false) ? FormBuild.buildLoader() : ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            _buildTitle(this.typeOfService),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: widget.assets,
                      label: "Equipment worked on *")
                ]
            ),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: widget.serviceType,
                      label: "Type of service *", onChangedValue: (value) {
                    setState(() {
                      print("Selected > Type Of Service : $value");
                      if (value is Dropdown) {
                        switch (value.id) {
                          case 2: {
                            this.typeOfService = ServiceType.LeakInspection;
                          }
                          break;
                          case 3: {
                            this.typeOfService = ServiceType.ServiceAndLeakRepair;
                          }
                          break;
                          case 5: {
                            this.typeOfService = ServiceType.Shutdown;
                          }
                          break;
                          default: {
                            this.typeOfService = ServiceType.None;
                          }
                          break;
                        }
                      }
                    });
                      })
                ]
            ),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: widget.leakDetectionMethod,
                      label: "Leak detection method*")
                  ]
            ),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: widget.wasLeakFound,
                      label:  "Was leak found? *", onChangedValue: (dropdown) {
                        setState(() {
                            if (dropdown is Dropdown) {
                              print("Was leak found selected > ${dropdown.name}");
                              if (dropdown.name == "Yes"){
                                _wasLeakFound = true;
                              }
                              else {
                                _wasLeakFound = false;
                              }
                            }
                          });
                      })
                ]
            ),
            Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FormBuild.buildDatePicker(key: Key("ServiceDateKey"), helper: "Service Date *"),
                ]
            ),
            //  === PART === Second part of the form
            _buildInspection(_wasLeakFound, this.typeOfService, verificationLeakFound: _wasVerificationLeakFound),
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
                  child: AppButton(
                    keyButton: Key('SubmitButton'),
                    titleButton: "SUBMIT",
                    onPressed: () {
                      print("This was pressed by Arnaud");
                    },
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
