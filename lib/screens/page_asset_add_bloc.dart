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

  // To add a textfield quickly
  Widget _buildTextField({String label, Key key, TextInputType inputType}) {
    return Expanded(
      flex: 1,
      child: AppTextField(labeled: label, keyTextField: key, keyboardType: inputType),
    );
  }

  Widget _buildImagePicker({String label, Key key, VoidCallback onPressed}) {
    return Expanded(
      flex: 1,
      child: ImagePickerTextField(labeled: label, onPressed: onPressed, keyImagePickerTextField: key,),
    );
  }

  // To build dropdown widget
  Widget _buildDropdown<T>(List<T> source, String label) {
    if (source == null) {
      print("Buid dropdown for '$label' is empty!");
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.yellow,
        ),
      );
    }
    int count = source.length;
    print("Buid dropdown for '$label' with count '$count'");
    if (source.length == 0) {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.red,
        ),
      );
    }
    if (source is List<Dropdown>) {
      return Expanded(
        flex: 1,
        child: DropdownFormField<String>(
          decoration: InputDecoration(labelText: label),
          items: source.map((i) {
            if (i is Dropdown) {
              Dropdown dropdown = i;
              String name = dropdown.name;
              return DropdownMenuItem<String>(
                value: name,
                child: Text('$name'),
              );
            }
            return DropdownMenuItem<String>(
              value: "",
              child: Text(""),
            );
          }).toList(),
        ),
      );
    }

    // Do nothing
    return Expanded(
      flex: 1,
      child: Container(),
    );
  }

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
        // This is hardcoded
        locations = [Dropdown(name: "0713", id: 1654321)];
        // This has been updated and added to dropdowns API Endpoint
        temperatureClass = [Dropdown(name: "Low", id: 1),
        Dropdown(name: "Medium", id: 2),
        Dropdown(name: "High", id: 3)];

        // This has been updated and added to dropdowns API Endpoint
//        materialType = [Dropdown(name: "Low", id: 1),
//        Dropdown(name: "Medium", id: 2),
//        Dropdown(name: "High", id: 3)];
      });
    };

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          children: <Widget>[
            (_isDropdownsLoaded == true) ? Row(
//              spacing: 8.0, // gap between adjacent chips
//              runSpacing: 4.0, // gap between lines
//              direction: Axis.horizontal,
              children: <Widget>[
                FormBuild.buildDropdown(materialType, "Material Type"),
                SizedBox(
                  width: 20,
                ),
                FormBuild.buildDropdown(materialType, "Material Type 2")
              ],
            )
                : Container()

          ],
    )
    );/* (_isDropdownsLoaded == false) ? Center(
      child: new CircularProgressIndicator(
          backgroundColor: Colors.red
      ),
    ): Scaffold(
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
        leading: Icon(
          Icons.close,
          color: Colors.black87,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white.withOpacity(0.0),
      ),
      body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 4.0, // gap between lines
                direction: Axis.horizontal,
                children: <Widget>[
                  FormBuild.buildDropdown(materialType, "Material Type"),
                  SizedBox(
                    width: 20,
                  ),
                  FormBuild.buildDropdown(materialType, "Material Type 2")
                ],
              ),
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
                    FormBuild.buildDropdown(materialType, "Type"),
                  ]
              ),
              Row(
                  children: <Widget>[
                    FormBuild.buildDropdown(coolingApplianceStatuses, "Appliance Status")
                  ]
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildDropdown(assetSubtypes, "Appliance Type")
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildDropdown(locations, "Locations"),
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
                  FormBuild.buildDropdown(materialType, "Material Type"),
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildTextField(key: Key("NameAppliance"), label: "Current Gas Weight", inputType: TextInputType.number),
                ],
              ),
              Row(
                children: <Widget>[
                  FormBuild.buildDropdown(temperatureClass, "Temperature Class"),
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
                        child: Text('Add Photos',
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
    */
  }
}
