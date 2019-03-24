import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/button_widget.dart';

class PageServiceEventAddBloc extends FormField<AppTextField> {
  PageServiceEventAddBloc({
    FormFieldSetter<AppTextField> onSaved,
    FormFieldValidator<AppTextField> validator,
    bool autovalidate = false
  }):super(
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<AppTextField> state) {
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            ListTile(
              title: Text("Add Appliance",
              style: TextStyle(
                  color: AppColors.gray,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  textBaseline: TextBaseline.ideographic,
                  fontFamily: "SF Pro Text Regular"
              ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Name'),
                ),
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Type'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Appliance Status'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Appliance Type'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Location'),
                ),
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Serial Number'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Tag Number'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Current Gas Weight'),
                ),
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Material Type'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Temperature Class'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Cooling Capacity'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Model'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppTextField(labeled: 'Model Number'),
                )
              ],
            )
          ],
        ),
      );
    }
  );
}
