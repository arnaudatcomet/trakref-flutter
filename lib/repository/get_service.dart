import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:trakref_app/repository/api_service.dart';

final BASE_URL = "https://api.trakref.com/v3.21";

class Dropdowns{
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

  Dropdowns({
    this.serviceActions,
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
    this.industryTypes
  });

  factory Dropdowns.fromJson(Map<String, dynamic> parsedJson){
    var serviceActionsList = parsedJson['serviceActions'] as List;
    var assetStatusesList = parsedJson['assetStatuses'] as List;
    var coolingApplianceStatusesList = parsedJson['coolingApplianceStatuses'] as List;
    var assetTypesList = parsedJson['assetTypes'] as List;
    var assetSubtypesList = parsedJson['assetSubtypes'] as List;
    var workItemStatusesList = parsedJson['workItemStatuses'] as List;
    var workItemTypesList = parsedJson['workItemTypes'] as List;
    var leakDetectionMethodsList = parsedJson['leakDetectionMethods'] as List;
    var purposesForAddingGasList = parsedJson['purposesForAddingGas'] as List;
    var materialTypesList = parsedJson['materialTypes'] as List;
    var materialStatusesList = parsedJson['materialStatuses'] as List;
    var leakRepairStatusesList = parsedJson['leakRepairStatuses'] as List;
    var leakLocationCategoriesList = parsedJson['leakLocationCategories'] as List;
    var leakLocationsList = parsedJson['leakLocations'] as List;
    var causeOfLeaksList = parsedJson['causeOfLeaks'] as List;
    var accountStatusesList = parsedJson['accountStatuses'] as List;
    var industryTypesList = parsedJson['industryTypes'] as List;

    return Dropdowns(
      serviceActions: serviceActionsList.map((i) => Dropdown.fromJson(i)).toList(),
      assetStatuses: assetStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      coolingApplianceStatuses: coolingApplianceStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      assetTypes: assetTypesList.map((i) => AssetTypesDropdown.fromJson(i)).toList(),
      assetSubtypes: assetSubtypesList.map((i) => Dropdown.fromJson(i)).toList(),
      workItemStatuses: workItemStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      workItemTypes: workItemTypesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakDetectionMethods: leakDetectionMethodsList.map((i) => Dropdown.fromJson(i)).toList(),
      purposesForAddingGas: purposesForAddingGasList.map((i) => Dropdown.fromJson(i)).toList(),
      materialTypes: materialTypesList.map((i) => Dropdown.fromJson(i)).toList(),
      materialStatuses: materialStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakRepairStatuses: leakRepairStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakLocationCategories: leakLocationCategoriesList.map((i) => Dropdown.fromJson(i)).toList(),
      leakLocations: leakLocationsList.map((i) => LeakLocationDropdown.fromJson(i)).toList(),
      causeOfLeaks: causeOfLeaksList.map((i) => Dropdown.fromJson(i)).toList(),
      accountStatuses: accountStatusesList.map((i) => Dropdown.fromJson(i)).toList(),
      industryTypes: industryTypesList.map((i) => Dropdown.fromJson(i)).toList(),
    );
  }
}

class Dropdown{
  String name; // Name
  int id;

  Dropdown({this.name, this.id}); // Dropdown ID

  factory Dropdown.fromJson(Map<String, dynamic> parsedJson){
    return Dropdown(
      id: parsedJson['ID'],
      name: parsedJson['Name']
    );
  }
}

class AssetTypesDropdown{
  String name; // Name
  int id;
  bool isCylinder;
  AssetTypesDropdown({this.name, this.id, this.isCylinder}); // Dropdown ID

  factory AssetTypesDropdown.fromJson(Map<String, dynamic> parsedJson){
    return AssetTypesDropdown(
        id: parsedJson['ID'],
        name: parsedJson['Name'],
        isCylinder: parsedJson['IsCylinder']
    );
  }
}

class LeakLocationDropdown{
  String name; // Name
  int id;
  String category; // Name
  int categoryID;

  LeakLocationDropdown({this.name, this.id, this.category, this.categoryID});

  factory LeakLocationDropdown.fromJson(Map<String, dynamic> parsedJson){
    return LeakLocationDropdown(
      id: parsedJson['ID'],
      name: parsedJson['Name'],
      category: parsedJson['Category'],
      categoryID: parsedJson['CategoryID']
    );
  }
}

class DropdownService {
  final String dropdownsURL = "$BASE_URL/dropdowns";
  static final DropdownService _shared = new DropdownService._internal();
  factory DropdownService() {
//    _shared.loadDropdowns();
    return _shared;
  }
  DropdownService._internal();

  Dropdowns dropdowns;
  VoidCallback onLoaded;
  ApiService api = ApiService();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<Dropdowns> loadDropdowns() async {
    String jsonResponse = await api.getStandard(dropdownsURL);
    dropdowns = Dropdowns.fromJson(_decoder.convert(jsonResponse));
    this.onLoaded();
    return dropdowns;
  }
}


class Accounts{
  final List<Account> accounts;
  Accounts({this.accounts});

  factory Accounts.fromJson(Map<String, dynamic> parsedJson){
    var accountsList = parsedJson as List;
    print("accountsList $accountsList");
    return Accounts(
      accounts: accountsList.map((i) => Account.fromJson(i)).toList(),
    );
  }
}

class Account{
  String name;
  int instanceID;
  int accountTypeID;
  String accountType;

  Account({this.name, this.instanceID, this.accountTypeID, this.accountType});

  List<Account> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Account>((json) => Account.fromJson(json)).toList();
  }

  factory Account.fromJson(Map<String, dynamic> parsedJson){
    print("Account $parsedJson");
    return Account(
        name: parsedJson['Name'],
        instanceID: parsedJson['InstanceID'],
        accountTypeID: parsedJson['AccountTypeID'],
        accountType: parsedJson['AccountType']
    );
  }
}

class AccountsService {
  final String accountsURL = "$BASE_URL/accounts";
  static final AccountsService _shared = new AccountsService._internal();
  factory AccountsService() {
    return _shared;
  }
  AccountsService._internal();

  List<Account> accounts;
  VoidCallback onLoaded;
  ApiService api = ApiService();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<List<Account>> loadAccounts() async {
    String jsonResponse = await api.getStandard(accountsURL);
    print("loadAccounts $jsonResponse");
    accounts = Account().parsePhotos(jsonResponse);
    this.onLoaded();
    return accounts;
  }
}