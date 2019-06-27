import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/viewmodel/base_model.dart';

class CylindersModel extends BaseModel {
  TrakrefAPIService _api = TrakrefAPIService();
  List<Asset> assets;
  TextEditingController controller;

  Future<String> scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      return barcode;
    }
    on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        return Future.error("The user did not grant the camera permission");
      } else {
        return Future.error("Unknown error happened when trying to scan barcode");
      }
    } on FormatException{
        return Future.error("The user click on back button without scanning anything");
    } catch (e) {
        return Future.error("Unknown error happened when trying to scan barcode");
    }
  }

  Future fetchCylinders() async {
    setState(ViewState.Busy);
    assets = await _api.getCylinders([]);
    setState(ViewState.Idle);
  }

  List<Asset> fetchFromSearch(String searchedText) {
    if (assets == null) return [];

    List<Asset> _filteredAssetsResult = [];
    String searchingFor = searchedText.toLowerCase();
    assets.forEach((asset) {
          String serialNumber = asset.serialNumber ?? "";
          String name = asset.name ?? "";
          String assetCategory = asset.assetCategory ?? "";
          String location = asset.location ?? "";
          if (serialNumber.toLowerCase().contains(searchingFor) ||
              name.toLowerCase().contains(searchingFor) ||
              assetCategory.toLowerCase().contains(searchingFor) ||
              location.toLowerCase().contains(searchingFor)) {
            _filteredAssetsResult.add(asset);
          }
    });

    return _filteredAssetsResult;
  }
}
