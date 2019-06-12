import 'package:get_it/get_it.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/viewmodel/accounts_model.dart';
import 'package:trakref_app/viewmodel/login_model.dart';
import 'package:trakref_app/viewmodel/workorders_model.dart';

GetIt locator = GetIt();

setupLocator() {
  locator.registerLazySingleton( () => TrakrefAPIService() );
  locator.registerLazySingleton( () => ApiService() );
  
  locator.registerFactory(() => AccountsModel());
  locator.registerFactory(() => WorkOrdersModel());
  locator.registerFactory(() => LoginModel());
}