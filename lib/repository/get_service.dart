import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:meta/meta.dart';

final BASE_URL = "https://api.trakref.com/v3.21";

class Dropdowns {
  final List<Dropdown> serviceActions;
  final List<Dropdown> assetStatuses;
  final List<Dropdown> coolingApplianceStatuses;
  final List<AssetTypesDropdown> assetTypes;
  final List<Dropdown> assetSubtypes;
  final List<Dropdown> workItemStatuses;
  final List<Dropdown> workItemTypes;
  final List<Dropdown> leakDetectionMethods;
  final List<Dropdown> purposesForAddingGas;
  final List<Dropdown> materialTypes;
  final List<Dropdown> materialStatuses;
  final List<Dropdown> leakRepairStatuses;
  final List<Dropdown> leakLocationCategories;
  final List<LeakLocationDropdown> leakLocations;
  final List<Dropdown> causeOfLeaks;
  final List<Dropdown> accountStatuses;
  final List<Dropdown> industryTypes;
  final List<Dropdown> temperatureClasses;

  Dropdowns(
      {this.serviceActions,
      this.assetStatuses,
      this.coolingApplianceStatuses,
      this.assetTypes,
      this.assetSubtypes,
      this.workItemStatuses,
      this.workItemTypes,
      this.leakDetectionMethods,
      this.purposesForAddingGas,
      this.materialTypes,
      this.materialStatuses,
      this.leakRepairStatuses,
      this.leakLocationCategories,
      this.leakLocations,
      this.causeOfLeaks,
      this.accountStatuses,
      this.industryTypes,
      this.temperatureClasses});

  factory Dropdowns.fromJson(Map<String, dynamic> parsedJson) {
    var serviceActionsList = parsedJson['serviceActions'] as List;
    var assetStatusesList = parsedJson['assetStatuses'] as List;
    var coolingApplianceStatusesList =
        parsedJson['coolingApplianceStatuses'] as List;
    var assetTypesList = parsedJson['assetTypes'] as List;
    var assetSubtypesList = parsedJson['assetSubtypes'] as List;
    var workItemStatusesList = parsedJson['workItemStatuses'] as List;
    var workItemTypesList = parsedJson['workItemTypes'] as List;
    var leakDetectionMethodsList = parsedJson['leakDetectionMethods'] as List;
    var purposesForAddingGasList = parsedJson['purposesForAddingGas'] as List;
    var materialTypesList = parsedJson['materialTypes'] as List;
    var materialStatusesList = parsedJson['materialStatuses'] as List;
    var leakRepairStatusesList = parsedJson['leakRepairStatuses'] as List;
    var leakLocationCategoriesList =
        parsedJson['leakLocationCategories'] as List;
    var leakLocationsList = parsedJson['leakLocations'] as List;
    var causeOfLeaksList = parsedJson['causeOfLeaks'] as List;
    var accountStatusesList = parsedJson['accountStatuses'] as List;
    var industryTypesList = parsedJson['industryTypes'] as List;
    var temperatureClassesList = parsedJson['temperatureClasses'] as List;

    return Dropdowns(
      serviceActions:
          serviceActionsList.map((i) => Dropdown.fromJson(i)).toList(),
      assetStatuses:
          assetStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      coolingApplianceStatuses: coolingApplianceStatusesList
          .map((i) => Dropdown.fromJson(i))
          .toList(),
      assetTypes:
          assetTypesList.map((i) => AssetTypesDropdown.fromJson(i)).toList(),
      assetSubtypes:
          assetSubtypesList.map((i) => Dropdown.fromJson(i)).toList(),
      workItemStatuses:
          workItemStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      workItemTypes:
          workItemTypesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakDetectionMethods:
          leakDetectionMethodsList.map((i) => Dropdown.fromJson(i)).toList(),
      purposesForAddingGas:
          purposesForAddingGasList.map((i) => Dropdown.fromJson(i)).toList(),
      materialTypes:
          materialTypesList.map((i) => Dropdown.fromJson(i)).toList(),
      materialStatuses:
          materialStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakRepairStatuses:
          leakRepairStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakLocationCategories:
          leakLocationCategoriesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakLocations: leakLocationsList
          .map((i) => LeakLocationDropdown.fromJson(i))
          .toList(),
      causeOfLeaks: causeOfLeaksList.map((i) => Dropdown.fromJson(i)).toList(),
      accountStatuses:
          accountStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      industryTypes:
          industryTypesList.map((i) => Dropdown.fromJson(i)).toList(),
      temperatureClasses:
          temperatureClassesList.map((i) => Dropdown.fromJson(i)).toList(),
    );
  }
}

class Dropdown {
  String name; // Name
  int id;

  Dropdown({this.name, this.id}); // Dropdown ID

  factory Dropdown.fromJson(Map<String, dynamic> parsedJson) {
    return Dropdown(id: parsedJson['ID'], name: parsedJson['Name']);
  }

  @override
  String toString() => '${this.name}';

  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Dropdown && other.id == id;
}

class AssetTypesDropdown {
  String name; // Name
  int id;
  bool isCylinder;

  AssetTypesDropdown({this.name, this.id, this.isCylinder}); // Dropdown ID

  factory AssetTypesDropdown.fromJson(Map<String, dynamic> parsedJson) {
    return AssetTypesDropdown(
        id: parsedJson['ID'],
        name: parsedJson['Name'],
        isCylinder: parsedJson['IsCylinder']);
  }

  @override
  String toString() => '${this.name}';
}

class LeakLocationDropdown {
  String name; // Name
  int id;
  String category; // Name
  int categoryID;

  LeakLocationDropdown({this.name, this.id, this.category, this.categoryID});

  factory LeakLocationDropdown.fromJson(Map<String, dynamic> parsedJson) {
    return LeakLocationDropdown(
        id: parsedJson['ID'],
        name: parsedJson['Name'],
        category: parsedJson['Category'],
        categoryID: parsedJson['CategoryID']);
  }

  @override
  String toString() => '${this.name}';
}

class DropdownService {
  final String dropdownsURL = "$BASE_URL/dropdowns";

  DropdownService._privateConstructor();
  static final DropdownService _shared = DropdownService._privateConstructor();

  factory DropdownService(){
    return _shared;
  }
  
  Dropdowns dropdowns;
  VoidCallback onLoaded;
  ApiService api = ApiService();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<Dropdowns> loadDropdowns() async {
    print("DropdownService is loading dropdowns");
    String jsonResponse = await api.getStandard(dropdownsURL);
    dropdowns = Dropdowns.fromJson(_decoder.convert(jsonResponse));
    print("DropdownService is dropdowns");
    this.onLoaded();
    return dropdowns;
  }
}

class Language {
  final String code;
  final String name;

  const Language(this.name, this.code);

  int get hashCode => code.hashCode;

  bool operator ==(Object other) => other is Language && other.code == code;

  @override
  String toString() => '${this.name}';
}
