import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

typedef AppCancellableTextFieldDelegate = void Function(dynamic);

class AppCancellableTextField extends StatefulWidget {
  final Function onChangedValue;
  final String textLabel;
  final String textKey;
  final String textError;
  final bool isRequired;
  final List<dynamic> sourcesDropdown;
  final dynamic initialValue;

  AppCancellableTextField({this.initialValue,
    @required this.onChangedValue,
    @required this.textLabel,
    this.textError,
    @required this.textKey,
    this.isRequired,
    @required this.sourcesDropdown});

  @override
  _AppCancellableTextFieldState createState() =>
      _AppCancellableTextFieldState();
}

class _AppCancellableTextFieldState extends State<AppCancellableTextField> {
  dynamic _pickedValue;

  void resetPickedValue() {
    _pickedValue = null;
  }

  @override
  void initState() {
    super.initState();
    _pickedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // Default it's not required
    bool isRequired = widget.isRequired ?? false;

    Widget selectedValue = Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check, color: AppColors.blueTurquoise, size: 14),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.textLabel,
                style: (isRequired == false)
                    ? Theme
                    .of(context)
                    .textTheme
                    .display3
                    : Theme
                    .of(context)
                    .textTheme
                    .display3
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                (_pickedValue == null) ? "" : _pickedValue.toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .display2
                    .copyWith(color: AppColors.blueTurquoise),
              )
            ],
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent),
              onPressed: () {
                _pickedValue = null;
                widget.onChangedValue(_pickedValue);
                setState(() {});
              })
        ],
      ),
    );

    Widget toSelectDropdown = FormBuild.buildDropdown(
        label: widget.textLabel,
        key: Key(widget.textKey),
        source: widget.sourcesDropdown,
        isRequired: isRequired,
        onChangedValue: (value) {
          print("onChangedValue $value");
          if (value is DropdownItem || value is AssetTypeItem) {
            print("onChangedValue id=${value.id} name=${value.name}");
            _pickedValue = value;
            widget.onChangedValue(_pickedValue);
            setState(() {});
          }
        },
        onValidator: (value) {
          if (widget.textError != null) {
            if (value == null) {
              return widget.textError;
            }
          }
        });

    return (_pickedValue != null) ? selectedValue : toSelectDropdown;
  }
}


typedef AppCancellableImagePickerDelegate = void Function(dynamic);

class AppCancellablePicker extends StatefulWidget {
  final Function onChangedValue;
  final String textLabel;
  final String textKey;
  final String textError;
  final bool isRequired;
  final List<dynamic> sourcesDropdown;
  final dynamic initialValue;

  AppCancellablePicker({this.initialValue,
    @required this.onChangedValue,
    @required this.textLabel,
    this.textError,
    @required this.textKey,
    this.isRequired,
    @required this.sourcesDropdown});

  @override
  _AppCancellablePickerState createState() =>
      _AppCancellablePickerState();
}

class _AppCancellablePickerState extends State<AppCancellablePicker> {
  dynamic _pickedValue;

  void resetPickedValue() {
    _pickedValue = null;
  }

  @override
  void initState() {
    super.initState();
    _pickedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // Default it's not required
    bool isRequired = widget.isRequired ?? false;

    Widget selectedValue = Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check, color: AppColors.blueTurquoise, size: 14),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.textLabel,
                style: (isRequired == false)
                    ? Theme
                    .of(context)
                    .textTheme
                    .display3
                    : Theme
                    .of(context)
                    .textTheme
                    .display3
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                (_pickedValue == null) ? "" : _pickedValue.toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .display2
                    .copyWith(color: AppColors.blueTurquoise),
              )
            ],
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.redAccent),
              onPressed: () {
                _pickedValue = null;
                widget.onChangedValue(_pickedValue);
                setState(() {});
              })
        ],
      ),
    );

    Widget imageToPick = Expanded(
      flex: 1,
      child: ImagePickerTextField(
        labeled: widget.textLabel,
        delegate: (retrieveImageValue) {
          _pickedValue = retrieveImageValue;
          widget.onChangedValue(_pickedValue);
          setState(() {});
        },
        keyImagePickerTextField: Key(widget.textKey),
      ),
    );

    Widget toSelectDropdown = FormBuild.buildDropdown(
        label: widget.textLabel,
        key: Key(widget.textKey),
        source: widget.sourcesDropdown,
        isRequired: isRequired,
        onChangedValue: (value) {
          print("onChangedValue $value");
          if (value is DropdownItem || value is AssetTypeItem) {
            print("onChangedValue id=${value.id} name=${value.name}");
            _pickedValue = value;
            widget.onChangedValue(_pickedValue);
            setState(() {});
          }
        },
        onValidator: (value) {
          if (widget.textError != null) {
            if (value == null) {
              return widget.textError;
            }
          }
        });

    return (_pickedValue != null) ? selectedValue : imageToPick;
  }
}