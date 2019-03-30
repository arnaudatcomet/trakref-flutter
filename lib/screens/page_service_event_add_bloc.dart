import "package:flutter/material.dart";
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:async/async.dart';

enum ServiceType { LeakInspection, ServiceAndLeakRepair, Shutdown, None }

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

  @override
  void initState() {
    super.initState();
    service.loadDropdowns();
    _isDropdownsLoaded = false;
    service.onLoaded = () {
      setState(() {
        _isDropdownsLoaded = true;
      });
    };
  }

  Future<Null> _selectDate(BuildContext context) async {
    // DateTime _date = DateTime.now();
    final DateTime picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2020));
    setState(() {
      print("Date picked is $picked");
      _date = picked;
    });
  }

  void _selectTypeOfService(BuildContext context) {
    setState(() {
//      _date = picked;
    });
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
                  FormBuild.buildDropdown(widget.assets, "Equipment Worked On *")
                ]
            ),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(widget.serviceType, "Type Of Service *")
                ]
            ),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(widget.leakDetectionMethod, "Leak Detection Method Used *")
                ]
            ),
            Row(
                children: <Widget>[
                  FormBuild.buildDropdown(widget.wasLeakFound, "Was Leak Found? *")
                ]
            ),
            Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FormBuild.buildDatePicker(key: Key("ServiceDateKey"), helper: "Service Date *"),
                ]
            ),
          ],
        )
      ),
    );
  }
}
