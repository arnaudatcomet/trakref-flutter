import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAssetAddBloc extends StatefulWidget {
  @override
  _PageAssetAddBlocState createState() => _PageAssetAddBlocState();
}

class _PageAssetAddBlocState extends State<PageAssetAddBloc> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DropdownService service = DropdownService();

  // controllers for form text controllers
  final TextEditingController _nameController = new TextEditingController();
  String name;

  bool _isDropdownsLoaded = false;
  List<AssetTypesDropdown> assetType;
  List<Dropdown> assetSubtypes;
  List<Dropdown> materialType;
  List<Dropdown> coolingApplianceStatuses;
  List<Dropdown> locations;
  // Need to check what it is in the dropdown API
  List<Dropdown> temperatureClass;
  @override
  void initState() {
    super.initState();
    _nameController.text = 'this is a test';
    service.loadDropdowns();
    _isDropdownsLoaded = false;
    service.onLoaded = () {
      setState(() {
        _isDropdownsLoaded = true;
        materialType = service.dropdowns.materialTypes;
        coolingApplianceStatuses = service.dropdowns.coolingApplianceStatuses;
        assetSubtypes = service.dropdowns.assetSubtypes;
        temperatureClass = service.dropdowns.temperatureClasses;

        // This is hardcoded
        locations = [Dropdown(name: "0713", id: 1654321)];
      });
    };

  }

  @override
  Widget build(BuildContext context) {
    return (_isDropdownsLoaded == false) ? FormBuild.buildLoader() : Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
            },
            child: Text("Save", style: TextStyle(
             color: AppColors.blueTurquoise
            )),
          )
        ],
        leading: IconButton(icon: Icon(
          Icons.close,
          color: Colors.black87,
        ), onPressed: (){
          Navigator.of(context).pop();
        }),
        elevation: 0.0,
        backgroundColor: Colors.white.withOpacity(0.0),
      ),
      body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text("Add Appliance",
                        style: Theme.of(context).textTheme.title,
                      )
                  )
                ],
              ),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FormBuild.buildTextField(key: Key("NameAppliance"), label: "Name"),
                  ]
              ),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FormBuild.buildDropdown(source: materialType, label: "Type", isRequired: true)
                  ]
              ),
              Row(
                  children: <Widget>[
                    FormBuild.buildDropdown(source: coolingApplianceStatuses, label: "Appliance Status", isRequired: true),
                    FormBuild.buildDropdown(source: assetSubtypes, label: "Appliance Type", isRequired: true)
                  ]
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: locations, label: "Locations", isRequired: true)
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildImagePicker(label: "Serial Number"),
                  FormBuild.buildImagePicker(label: "Tag Number")
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: materialType, label: "Material Type", isRequired: true)
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildTextField(key: Key("NameAppliance"), label: "Current Gas Weight", inputType: TextInputType.number),
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildDropdown(source: temperatureClass, label: "Temperature Class", isRequired: true)
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildTextField(key: Key("CoolingCapacity"), label: "Cooling Capacity"),
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          print("FlatButton pressed");
                        },
                        child: Text('ADD PHOTO(S)',
                            style: TextStyle(
                                color: AppColors.blueTurquoise
                            )),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildTextField(key: Key("InstallDate"), label: "Install Date"),
                ],
              ),

            ],
          )
      )
    );
  }
}
