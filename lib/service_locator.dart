import 'package:get_it/get_it.dart';
import 'package:trakref_app/repository/api/cached_api_service.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/viewmodel/accounts_model.dart';
import 'package:trakref_app/viewmodel/adding_new_menu_model.dart';
import 'package:trakref_app/viewmodel/cylinder_model.dart';
import 'package:trakref_app/viewmodel/dropdown_model.dart';
import 'package:trakref_app/viewmodel/locations_model.dart';
import 'package:trakref_app/viewmodel/login_model.dart';
import 'package:trakref_app/viewmodel/workorders_model.dart';

GetIt locator = GetIt();

setupLocator() {
  locator.registerLazySingleton( () => TrakrefAPIService() );
  locator.registerLazySingleton( () => ApiService() );
  locator.registerLazySingleton( () => CachingAPIService() );
  
  
  locator.registerFactory(() => DropdownsModel());
  locator.registerFactory(() => AccountsModel());
  locator.registerFactory(() => WorkOrdersModel());
  locator.registerFactory(() => LocationsModel());
  locator.registerFactory(() => CylindersModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => AddingNewMenuModel());
}