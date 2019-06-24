import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class CylinderAddModel extends BaseModel {
  CachingAPIService _cachingAPIService = CachingAPIService();
  TrakrefAPIService _api = TrakrefAPIService();

  TextEditingController _nameController = TextEditingController();
  /// Allow view model to retrieve 'name' string value from textfield
  TextEditingController get nameController => _nameController;

  TextEditingController _currentGasWeightController = TextEditingController();
  /// Allow view model to retrieve 'current gas weight' string value from textfield
  TextEditingController get currentGasWeightController =>
      _currentGasWeightController;

  TextEditingController _maxGasWeightController = TextEditingController();
  /// Allow view model to retrieve 'max gas weight' string value from textfield
  TextEditingController get maxGasWeightController => _maxGasWeightController;

  List<AssetTypeItem> _assetType;
  List<AssetTypeItem> get assetTypes => _assetType;
  AssetTypeItem pickedAssetTypes;

  List<DropdownItem> _assetSubtypes;
  List<DropdownItem> get assetSubtypes => _assetSubtypes;
  DropdownItem pickedAssetSubTypes;

  List<DropdownItem> _materialType;
  List<DropdownItem> get materialType => _materialType;
  DropdownItem pickedMaterialTypes;

  List<DropdownItem> _coolingApplianceStatuses;
  List<DropdownItem> get coolingApplianceStatuses => _coolingApplianceStatuses;
  DropdownItem pickedCoolingApplianceStatuses;

  String pickedSerialNumber;
  String pickedTagNumber;

  List<DropdownItem> _assetCategories = [
    DropdownItem(id: 1, name: "HVAC/R Systems"),
    DropdownItem(id: 7, name: "SF6 Equipment")
  ];
  List<DropdownItem> get assetCategories => _assetCategories;
  DropdownItem pickedAssetCategories;

  List<DropdownItem> _systemStatuses;
  List<DropdownItem> get systemStatuses => _systemStatuses;
  DropdownItem pickedSystemStatuses;

  List<Location> _locations;
  List<Location> get locations => _locations;
  // We will have to move that some functions instead of properties ; maybe use the caching
  List<DropdownItem> _locationsDropdowns;
  List<DropdownItem> get locationsDropdowns => _locationsDropdowns;
  DropdownItem pickedLocation;

  /// Will load all the dropdowns, and locations to view model
  fetchRespectiveDropdowns() async {
    setState(ViewState.Busy);
    DropdownList dropdowns = await _fetchDropdowns();
    _materialType = dropdowns.materialTypes
        .map((item) => DropdownItem(name: item.name, id: item.id))
        .toList();
    _coolingApplianceStatuses = dropdowns.coolingApplianceStatuses
        .map((item) => DropdownItem(name: item.name, id: item.id))
        .toList();
    _assetType = dropdowns.assetTypes.where((i) => (i.id == 3 || i.id == 4 || i.id == 5)).map((i) => AssetTypeItem(id: i.id, name: i.name, isCylinder: i.isCylinder)).toList();
    _assetSubtypes = dropdowns.assetSubtypes
        .map((item) => DropdownItem(name: item.name, id: item.id))
        .toList();
    _systemStatuses = dropdowns.assetStatuses.map((item) => DropdownItem(id: item.id, name: item.name)).toList();

    // Fetch the locations source and construct the dropdowns
    await _fetchLocations();

    setState(ViewState.Idle);
  }

  _fetchLocations() async {
    _locations = await _api.getLocations();
    _locationsDropdowns = locations
        .map((location) => DropdownItem(name: location.name, id: location.ID))
        .toList();
  }

  Future<DropdownList> _fetchDropdowns() async {
    DropdownList dropdowns = _cachingAPIService.cachedDropdowns ?? [];
    return dropdowns;
  }
  
  /// Post a new cylinder to Trakref API
  Future<bool> postCylinder({Function onDone, Function onError}) async {
    double currentGasWeight = 0;
    double maxGasWeight = 0;
    try {
      currentGasWeight = double.parse(currentGasWeightController.text);
    } catch (error) {
      return false;
    }

    try {
      maxGasWeight = double.parse(maxGasWeightController.text);
    } catch (error) {
      return false;
      }

    print("Name : ${nameController.text ?? ""}");
    print("Current Gas Weight : ${currentGasWeightController.text ?? ""}");
    print("Max Gas Weight : ${maxGasWeightController?.text ?? ""}");
    print("Appliance Status : ${pickedCoolingApplianceStatuses?.name ?? ""}");
    print("Appliance Type : ${pickedAssetTypes?.name ?? ""}");
    print("Appliance SubType : ${pickedAssetSubTypes?.name ?? ""}");
    print("Appliance Category : ${pickedAssetCategories?.name ?? ""}");
    print("Tag Number : ${pickedTagNumber ?? ""}");
    print("Serial Number : ${pickedSerialNumber ?? ""}");
    print("Location : ${pickedLocation?.name ?? ""}");
    print("Material type : ${pickedMaterialTypes?.name ?? ""}");
    print("System Status : ${pickedSystemStatuses?.name ?? ""}");

    Asset cylinder = Asset(
      name: nameController.text,
      currentGasWeightLbs: currentGasWeight,
      maxGasCapacityLbs: maxGasWeight,
      coolingApplianceStatusID: pickedCoolingApplianceStatuses.id,
      assetTypeID: pickedAssetTypes.id,
      assetSubtypeID: pickedAssetSubTypes.id,
      assetCategoryID: pickedAssetCategories.id,
      locationID: pickedLocation.id,
      materialTypeID: pickedMaterialTypes.id,
      assetStatusID: pickedSystemStatuses.id,
    );

    _api.writeOnDisk<Asset>([cylinder]);

    _api.postCylinder(cylinder).then((result) {
      print("post cylinder result $result");
      if (onDone != null) {
        onDone();
      }
    }).catchError((error) {
      if (onError != null) {
        onError(error);
      }
    });
  }

  String onValidate(TextEditingController textController) {
    if (textController == _nameController && _nameController.text.isEmpty) {
      return "Required";
    }
    return null;
  }
}
