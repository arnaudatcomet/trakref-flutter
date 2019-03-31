import "package:flutter/material.dart";
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:async/async.dart';

enum ServiceType { LeakInspection, ServiceAndLeakRepair, Shutdown, None }

class LeakInspectionForm extends StatelessWidget {
  List<Dropdown> locationLeakFound;
  List<Dropdown> causeOfLeaks;
  DateTime followUpDate = DateTime.now();
  double estimatedLeak;

  LeakInspectionForm({this.locationLeakFound, this.causeOfLeaks,
    this.followUpDate, this.estimatedLeak});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          FormBuild.buildDropdown(source: this.locationLeakFound,
              label: "Where was leak found? *"),
          FormBuild.buildDropdown(source: this.causeOfLeaks,
              label: "Cause of leak *"),
              FormBuild.buildTextField(label: "Estimated leak amount"),
          FormBuild.buildDatePicker(label: "Follow Up Date*")
        ]
    );
  }
}


class PageServiceEventAddBloc extends StatefulWidget {
  // Example dropdowns
  List<Dropdown> assets = [
    Dropdown(name: 'Electricity Meter 1', id: 1000018),
    Dropdown(name: '528 RDD Multi Temp', id: 1000022),
    Dropdown(name: 'Virgin R-408a lbs. 1000 457474', id: 1000026),
    Dropdown(name: 'Virgin R-404A lbs. 100 234567', id: 1000027),
    Dropdown(name: 'Virgin R-449A lbs. 115 12312211', id: 1000038),
    Dropdown(name: 'MR718', id: 1000055)
  ];

  List<Dropdown> serviceType = [
    Dropdown(name: 'Leak Inspection', id: 2),
    Dropdown(name: 'Service and Leak Repair', id: 3),
    Dropdown(name: 'Shutdown', id: 5)
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

  List<Dropdown> wasLeakFound = [
    Dropdown(name: 'Yes', id: 1),
    Dropdown(name: 'No', id: 0)
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

  @override
  void initState() {
    super.initState();
//    service.loadDropdowns();
//    _isDropdownsLoaded = false;
//    service.onLoaded = () {
//      setState(() {
//        _isDropdownsLoaded = true;
//      });
//    };
    _isDropdownsLoaded = true;
  }

  Future<Null> _selectDate(BuildContext context) async {
    // DateTime _date = DateTime.now();
    final DateTime picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2020));
    setState(() {
      print("Date picked is $picked");
      _date = picked;
    });
  }

  Widget _buildLeakInspection(bool leakFound, ServiceType type) {
    print("===> leakFound ? $leakFound,  type ? $type");
    // Show leak inspection
    if (leakFound == true) {
      if (type == ServiceType.LeakInspection) {
        print("===> buildLeakInspection");
        return LeakInspectionForm(causeOfLeaks: widget.causeOfLeaks,
            locationLeakFound: widget.locationLeakFound);
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
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text("Add Service Event",
                      style: Theme.of(context).textTheme.title,
                    )
                )
              ],
            ),
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
                        print("Selected > Type Of Service : $value");
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
                      label:  "Was leak found? *", onChangedValue: (value) {
                        setState(() {
                          if (value == "true") {
                            _wasLeakFound = true;
                          }
                          else {
                            _wasLeakFound = false;
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
            _buildLeakInspection(_wasLeakFound, this.typeOfService)
          ],
        )
      ),
    );
  }
}
