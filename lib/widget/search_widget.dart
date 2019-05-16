import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

typedef SearchWidgetDelegate = void Function(String);

class SearchWidget extends StatelessWidget {
  TextEditingController controller;

  SearchWidget({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,
                color: AppColors.lightGray,
                size: 22.0
            ),
            contentPadding: EdgeInsets.only(left: 15, top: 13),
            hintText: 'Search by Event, Cylinders or Locations',
            hintStyle: TextStyle(
                color: AppColors.lightGray,
                fontSize: 14,
                fontFamily: 'Quicksand'
            )
        ),
      ),
    );
  }
}
