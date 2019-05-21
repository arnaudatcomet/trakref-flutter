import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/screens/adding/app_cancellable_textfield_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAssetAddBloc extends StatefulWidget {
  PageAssetAddBloc();

  @override
  _PageAssetAddBlocState createState() => _PageAssetAddBlocState();
}

class _PageAssetAddBlocState extends State<PageAssetAddBloc> {
  bool _isDropdownsLoaded = false;

  TextEditingController nameController;
  TextEditingController currentGasWeightController;
  TextEditingController maxGasWeightController;

  List<DropdownItem> coolingApplianceStatuses;
  DropdownItem _pickedCoolingApplianceStatuses;

  List<AssetTypeItem> assetTypes;
  AssetTypeItem _pickedAssetTypes;

  List<DropdownItem> assetSubTypes;
  DropdownItem _pickedAssetSubTypes;

  List<DropdownItem> assetCategories = [
    DropdownItem(
      id: 1,
      name: "HVAC/R Systems"
    ),
    DropdownItem(
        id: 7,
        name: "SF6 Equipment"
    )
  ];
  DropdownItem _pickedAssetCategories;

  List<DropdownItem> materialTypes;
  DropdownItem _pickedMaterialTypes;

  List<DropdownItem> systemStatuses;
  DropdownItem _pickedSystemStatuses;

  List<Location> locations;
  List<DropdownItem> locationsDropdowns;
  DropdownItem _pickedLocations;

  Future<bool> postCylinder() async {

    double currentGasWeight = 0;
    double maxGasWeight = 0;
    try {
      currentGasWeight = double.parse(currentGasWeightController.text);
    }
    catch (error) {}

    try {
      maxGasWeight = double.parse(maxGasWeightController.text);
    }
    catch (error) {}

    print("Name : ${nameController.text}");
    print("Current Gas Weight : ${currentGasWeightController.text}");
    print("Max Gas Weight : ${maxGasWeightController.text}");
    print("Appliance Status : ${_pickedCoolingApplianceStatuses.name}");
    print("Appliance Type : ${_pickedAssetTypes.name}");
    print("Appliance SubType : ${_pickedAssetSubTypes.name}");
    print("Appliance Category : ${_pickedAssetCategories.name}");
//                print("Tag Number : ### NEED TO DEFINE ###");
//                print("Serial Number : ### NEED TO DEFINE ###");
    print("Location : ${_pickedLocations.name}");
    print("Material type : ${_pickedMaterialTypes.name}");
    print("System Status : ${_pickedSystemStatuses.name}");

    Asset cylinder = Asset(
      name: nameController.text,
      currentGasWeightLbs: currentGasWeight,
      maxGasCapacityLbs: maxGasWeight,
      coolingApplianceStatusID: _pickedCoolingApplianceStatuses
          .id,
      assetTypeID: _pickedAssetTypes.id,
      assetSubtypeID: _pickedAssetSubTypes.id,
      assetCategoryID: _pickedAssetCategories.id,
      locationID: _pickedLocations.id,
      materialTypeID: _pickedMaterialTypes.id,
      assetStatusID: _pickedSystemStatuses.id,
    );

    TrakrefAPIService().writeOnDisk<Asset>([cylinder]);

    TrakrefAPIService().postCylinder(cylinder).then((result) {
      showConfirmationMessage();
    }).catchError((error) {
      showErrorMessage(kAddServiceEventErrorMessage);
    });
  }

  @override
  void initState() {
    // Listening to textchanges
    nameController = TextEditingController();
    nameController.addListener(onNameChanged);

    currentGasWeightController = TextEditingController();
    currentGasWeightController.addListener(onCurrentGasWeightChanged);

    maxGasWeightController = TextEditingController();
    maxGasWeightController.addListener(onMaxGasWeightChanged);

    // GET dropdowns
    TrakrefAPIService().getDropdown().then((results) {
      coolingApplianceStatuses = results.coolingApplianceStatuses;
      //            if (asset.AssetTypeID != 3 && asset.AssetTypeID != 4 && asset.AssetSubtypeID != 83 && asset.AssetSubtypeID != 84)
      //                ThrowException("Error: Can only create cylinders from the mobile app");
      assetTypes = results.assetTypes.where((i) => (i.id == 3 || i.id == 4 || i.id == 5)).toList();
      assetSubTypes = results.assetSubtypes.where((i) => (i.id == 83 || i.id == 84)).toList();

      materialTypes = results.materialTypes;
      systemStatuses = results.assetStatuses;

      TrakrefAPIService().getLocations().then((loc){
        print("getLocations > ${loc.length}");
        locations = loc;
        locationsDropdowns = locations.map((i) => DropdownItem(id: i.ID, name: i.name)).toList();

        // GET locations
        _isDropdownsLoaded = true;

        setState(() {});
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Spacer
    SizedBox ColumnSpacer = SizedBox(
      width: 20,
    );

    // Body
    ListView NewAddApplianceWidget = ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text("Add Cylinder",
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                )
            )
          ],
        ),
        Row(
          children: <Widget>[
            FormBuild.buildTextField(key: Key("SystemNameKey"),
                textController: nameController,
                label: "Name",
                initialValue: null),
          ],
        ),
        Row(
          children: <Widget>[
            FormBuild.buildTextField(key: Key("CurrentGasWeightKey"),
                textController: currentGasWeightController,
                label: "Current Gas Weight",
                inputType: TextInputType.numberWithOptions(decimal: true),
                initialValue: null),
            ColumnSpacer,
            FormBuild.buildTextField(key: Key("MaxGasWeightKey"),
                textController: maxGasWeightController,
                label: "Max Gas Weight",
                inputType: TextInputType.numberWithOptions(decimal: true),
                initialValue: null),
          ],
        ),
        Row(
          children: <Widget>[
            AppCancellableTextField(
                initialValue: _pickedCoolingApplianceStatuses,
                sourcesDropdown: this.coolingApplianceStatuses,
                textKey: "ApplianceStatusKey",
                textLabel: "Appliance Status",
                textError: "Required",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedCoolingApplianceStatuses = value;
                })
          ],
        ),
        Row(
          // From dropdowns = assetTypes
          children: <Widget>[
            AppCancellableTextField(
                initialValue: _pickedAssetTypes,
                sourcesDropdown: this.assetTypes,
                textKey: "ApplianceTypeKey",
                textLabel: "Appliance Type",
                textError: "Required",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedAssetTypes = value;
                })
          ],
        ),
        Row(
          // From dropdowns = assetSubTypes
          children: <Widget>[
            AppCancellableTextField(
                initialValue: _pickedAssetSubTypes,
                sourcesDropdown: this.assetSubTypes,
                textKey: "ApplianceTypeKey",
                textLabel: "Appliance Sub Type",
                textError: "Required",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedAssetSubTypes = value;
                })
          ],
        ),
        Row(
          // From dropdowns = assetSubTypes
          children: <Widget>[
            AppCancellableTextField(
                initialValue: _pickedAssetCategories,
                sourcesDropdown: this.assetCategories,
                textKey: "ApplianceTypeKey",
                textLabel: "Appliance Category",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedAssetCategories = value;
                })
          ],
        ),
        Row(
          children: <Widget>[
            AppCancellableTextField(
                initialValue: _pickedLocations,
                sourcesDropdown: this.locationsDropdowns,
                textKey: "LocationKey",
                textLabel: "Location",
                textError: "Required",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedLocations = value;
                }),
          ],
        ),
        Row(
          children: <Widget>[
            // Need to be able to take pictures of tag numbers
            FormBuild.buildTextField(key: Key("TagNumberKey"),
                label: "Tag Number",
                initialValue: null),
            ColumnSpacer,
            // Need to be able to take pictures of serial numbers
            FormBuild.buildTextField(key: Key("SerialNumberKey"),
                label: "Serial Number",
                initialValue: null),
          ],
        ),
        Row(
          children: <Widget>[
            AppCancellableTextField(
                initialValue: _pickedMaterialTypes,
                sourcesDropdown: this.materialTypes,
                textKey: "MaterialTypeKey",
                textLabel: "MaterialType",
                textError: "Required",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedMaterialTypes = value;
                })
          ],
        ),
        Row(
          children: <Widget>[
            // From dropdowns = cooling capacity
            AppCancellableTextField(
                initialValue: _pickedSystemStatuses,
                sourcesDropdown: this.systemStatuses,
                textKey: "SystemStatusesKey",
                textLabel: "System Status",
                textError: "Required",
                isRequired: true,
                onChangedValue: (value) {
                  _pickedSystemStatuses = value;
                }),
          ],
        ),
      ],
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                postCylinder().then((succeeded) {
                  if (succeeded != null) {
                    showConfirmationMessage();
                  }
                });
              },
              child: Text("Save", style: TextStyle(
                  color: AppColors.blueTurquoise
              )),
            )
          ],
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: AppColors.gray),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.0),
        ),
        body: SafeArea(
            child:(_isDropdownsLoaded == false) ? FormBuild.buildLoader() : NewAddApplianceWidget
        )
    );
  }

  // Listeners
  void onNameChanged() {
    print("${nameController.text}");
  }

  void onCurrentGasWeightChanged() {
    print("${currentGasWeightController.text}");
  }

  void onMaxGasWeightChanged() {
    print("${maxGasWeightController.text}");
  }

  void showConfirmationMessage() {
    Flushbar(
      duration:  Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.white,
      boxShadows: [BoxShadow(color: Colors.black, offset: Offset(0.0, 0.2), blurRadius: 0.0)],
      messageText: Text(kAddServiceEventSuccessfulMessage),
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
      Navigator.of(context).pop();
    });
  }

  void showErrorMessage(String errorMessage) {
    Flushbar(
      duration:  Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.white,
      boxShadows: [BoxShadow(color: Colors.black, offset: Offset(0.0, 0.2), blurRadius: 0.0)],
      messageText: Text(errorMessage),
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
    });
  }
}