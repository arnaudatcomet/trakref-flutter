import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class CylindersModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  List<Asset> assets;
  TextEditingController controller;

  Future fetchCylinders() async {
    setState(ViewState.Busy);
    assets = await _api.getCylinders([]);
    setState(ViewState.Idle);
  }

  List<Asset> fetchFromSearch(String searchedText) {
    if (assets == null) return [];

    List<Asset> _filteredAssetsResult = [];
    assets.forEach((asset) {
          String serialNumber = asset.serialNumber ?? "";
          String name = asset.name ?? "";
          String assetCategory = asset.assetCategory ?? "";
          String location = asset.location ?? "";
          if (serialNumber.toLowerCase().contains(searchedText) ||
              name.toLowerCase().contains(searchedText) ||
              assetCategory.toLowerCase().contains(searchedText) ||
              location.toLowerCase().contains(searchedText)) {
            _filteredAssetsResult.add(asset);
          }
    });

    return _filteredAssetsResult;
  }
}
