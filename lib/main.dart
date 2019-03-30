import 'package:flutter/material.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/routes.dart';

void main() => runApp(MyApp());

const kPrimaryColor = const Color(0xFF81c784);
const kPrimaryLight = const Color(0xFFb2fab4);
const kPrimaryDark = const Color(0xFF519657);
const kSecondaryColor = const Color(0xFF4dd0e1);
const kSecondaryLight = const Color(0xFF88ffff);
const kSecondaryDark = const Color(0xFF009faf);

class AppColors {
  static final gray = Color.fromRGBO(51, 51, 51, 1);
  static final lightGray = Color.fromRGBO(107, 114, 125, 1);
  static final blueTurquoise = Color.fromRGBO(48, 125, 140, 1);
  static final lightGreen = Color.fromRGBO(140, 220, 84, 1);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: buildTheme(),
      routes: routes,
    );
  }
}

ThemeData buildTheme() {
  final baseTheme = ThemeData(
    fontFamily: "SF Pro Text"
  );

  return baseTheme.copyWith(
    primaryColor: Color.fromRGBO(42, 45, 49, 1),
    primaryColorDark: kPrimaryDark,
    primaryColorLight: kPrimaryLight,
    textSelectionColor: Colors.red,
    accentColor: kSecondaryColor,
    bottomAppBarColor: kSecondaryDark,
    buttonColor: kSecondaryColor,
    sliderTheme: SliderThemeData.fromPrimaryColors(
      primaryColor: kPrimaryColor,
      primaryColorDark: kPrimaryDark,
      primaryColorLight: kPrimaryLight,
      valueIndicatorTextStyle: TextStyle(),
    ),
    textTheme: TextTheme().copyWith(
      title: TextStyle(
          color: AppColors.gray,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: "SF Pro Text Regular"
      ),
      subhead: TextStyle(
          color: AppColors.gray,
          decorationColor: AppColors.lightGray,
          fontFamily: "SF Pro Text Regular"
        ),
      // This is used for the cells
      display1: TextStyle(
          color: AppColors.blueTurquoise,
          fontSize: 14,
          fontFamily: "SF Pro Text Regular"
      ),
      display2: TextStyle(
          color: AppColors.gray,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: "SF Pro Text Regular"
      ),
      display3: TextStyle(
          color: AppColors.gray,
          fontSize: 12,
          fontFamily: "SF Pro Text Regular"
      ),
      display4: TextStyle(
          color: AppColors.gray,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: "SF Pro Text Regular"
      ),
      body1: TextStyle(
          color: AppColors.gray,
          fontSize: 15,
          fontFamily: "SF Pro Text Regular"
      )
    ),
  );
}