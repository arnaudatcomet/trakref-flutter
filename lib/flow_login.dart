import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/service_locator.dart';

void main() {
  enableFlutterDriverExtension();

  setupLocator();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark, //top bar icons
    statusBarBrightness: Brightness.light, //
  ));

  runApp(MyApp());
}