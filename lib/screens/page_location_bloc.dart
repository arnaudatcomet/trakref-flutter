import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

class LocationTextField extends StatelessWidget {
  String labeled = "This is an exemple";

  LocationTextField(this.labeled);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: TextField(
        decoration: InputDecoration(
            labelText: labeled,
            border: const UnderlineInputBorder()
        ),
      ),
    );
  }
}

class LocationModel {
  String _nameKey;
  String _codeKey;
  String _locationTypeKey;
  String _firstnameKey;
  String _lastnameKey;
  String _phoneKey;
  String _mailingAddress1Key;
  String _mailingCityKey;
  String _mailingStateKey;
  String _mailingZipKey;
  String _mailingCountryKey;
  String _isOffsiteKey;

  LocationModel(this._nameKey, this._codeKey);
}

class PageLocationsBloc extends FormField<LocationModel> {
  PageLocationsBloc({
    FormFieldSetter<LocationModel> onSaved,
    FormFieldValidator<LocationModel> validator,
    bool autovalidate = false
  }) : super(
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<LocationModel> state) {
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            ListTile(
               title: Text(
                  "Location",
                  // Probably need to move that somewhere
                  style: TextStyle(
                      color: AppColors.gray,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "SF Pro Text Regular"
                  ),
                ),
            ),
            // First Line: Location Code and Location Type
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: LocationTextField('Location Code'),
                ),
                Expanded(
                  flex: 1,
                  child: LocationTextField('Location Type'),
                )
              ],
            ),
            // Second Line: Street Name
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: LocationTextField('Street Name'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: LocationTextField('City'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: LocationTextField('State'),
                ),
                Expanded(
                  flex: 1,
                  child: LocationTextField('Zip Code'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: LocationTextField('Contact Name'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: LocationTextField('Phone Number'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: LocationTextField('Association'),
                )
              ],
            )
          ],
        ),
      );
    });
}