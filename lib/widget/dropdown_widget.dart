import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/button_widget.dart';

// Dropdowns
class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    Key key,
    InputDecoration decoration,
    T initialValue,
    List<DropdownMenuItem<T>> items,
    bool autovalidate = false,
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    FormFieldSetter<T> onChanged,
    T firstValue
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          initialValue: initialValue/* items.contains(initialValue) ? initialValue : null */,
          builder: (FormFieldState<T> field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            // value == null || items.where((DropdownMenuItem<T> item) => item.value == value).length == 1
           return Container(
                child: InputDecorator(
              decoration: effectiveDecoration.copyWith(
                  errorText: field.hasError ? field.errorText : null,
                  fillColor: Colors.white),
              isEmpty: field.value == '' || field.value == null,
              child: Container(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    isExpanded: true,
                    value: field.value,
                    isDense: true,
                    onChanged: (value) {
                      if (value != null) {
                        field.didChange(value);
                        if (onChanged != null) {
                          onChanged(value);
                        }
                      }
                    },
                    items: (items == null) ? [] : items.toList(),
                  ),
                ),
              ),
            ));
          },
        );
}

class FormBuild {
  static Widget buildTinyTextField({String initialValue, String label, Color labelColor, Color textColor}) {
    return TextFormField(
      enabled: false,
      initialValue: "${initialValue ?? ""}",
      style: TextStyle(color: textColor ?? Colors.black),
      decoration: InputDecoration(
          labelStyle: TextStyle(
              color: labelColor ?? AppColors.blueTurquoise, fontWeight: FontWeight.bold),
          labelText: "${label ?? ""}",
          border: InputBorder.none),
    );
  }
  // Convenient Loader
  static Widget buildLoader() {
    return Center(
      child: new CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueTurquoise),
      ),
    );
  }

  static void showFlushBarMessage(BuildContext context, String msg, Function showCallback, {int duration}) {
    Flushbar(
      duration:  Duration(seconds: (duration) ?? 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.white,
      boxShadows: [BoxShadow(color: Colors.black, offset: Offset(0.0, 0.2), blurRadius: 0.0)],
      messageText: Text(msg),
      mainButton: FlatButton(
        onPressed: () {},
        child: FlatButton(onPressed: () {
          Flushbar().dismiss();
        }, child: Text(
          "GOT IT", //dismiss
          style: TextStyle(color: Colors.black),
        )),
      ),
    )..show(context).then((r){
      showCallback();
    });
  }

  // To add a row textfield quicker
  static Widget buildTextfieldRow(String key, String label, String initialValue, {bool enabled}) {
    if (initialValue == null) {
      return Row(mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FormBuild.buildTextField(key: Key(key), label: label, enabled: enabled ?? true)
          ]
      );
    }
    return Row(mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FormBuild.buildTextField(key: Key(key), label: label, initialValue: initialValue, enabled: enabled ?? true)
        ]
    );
  }

  // To add a textfield quickly
  static Widget buildTextField({
    String label,
    Key key,
    TextInputType inputType,
    ValueChanged<String> onSubmitted,
    ValueChanged<String> onValidated,
    TextEditingController textController,
    String initialValue,
    bool enabled
  }) {
    return Expanded(
      flex: 1,
      child: AppTextField(
        onValidated: onValidated,
        labeled: label,
        keyTextField: key,
        keyboardType: inputType,
        onSubmitted: onSubmitted,
        initialValue: initialValue,
        textController: textController,
        enabled: enabled,
      ),
    );
  }

  static Widget buildImagePicker(
      {String label, Key key, VoidCallback onPressed}) {
    return Expanded(
      flex: 1,
      child: ImagePickerTextField(
        labeled: label,
        onPressed: onPressed,
        keyImagePickerTextField: key,
      ),
    );
  }

  static Widget buildDatePicker(
      {String label,
      String helper,
      Key key,
      ValueChanged<String> onValidated,
      ValueChanged<String> onSaved,
      ValueChanged<DateTime> onPressed,
      DateTime startDate,
      DateTime endDate}) {
    return Expanded(
      flex: 1,
      child: DatePickerTextField(
        onValidated: onValidated,
        labeled: label,
        helper: helper,
        onPressed: onPressed,
        keyDatePickerTextField: key,
      ),
    );
  }

  static Widget buildNewDropdown<T>(
      {String hint,
      T selectedValue,
      FormFieldSetter<T> onChanged,
      List<T> sources,
      Key key}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        hint: Text(hint),
        key: key,
        value: selectedValue,
        onChanged: onChanged,
        items: sources.map((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: new Text("$value"),
          );
        }).toList(),
      ),
    );
  }

  static Widget buildDropdown<T>(
      {List<T> source,
      bool autovalidate = false,
        String label,
        T initialValue,
        FormFieldSetter onChangedValue,
        Key key,
        FormFieldValidator<T> onValidator,
        FormFieldSetter<T> onSaved,
        @required bool isRequired}) {
    if (source == null) {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.yellow,
        ),
      );
    }
    
    if (source.length < 1) {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.red,
        ),
      );
    }

    var dropdownFormField = DropdownFormField<T>(
        key: key,
        validator: onValidator,
        autovalidate: autovalidate,
        onChanged: onChangedValue,
        initialValue: initialValue,
        onSaved: onSaved,
        decoration:
            InputDecoration(labelText: (isRequired) ? "$label *" : label),
        items: source.map((i) {
          return DropdownMenuItem<T>(
            value: i,
            child: Text("$i"),
          );
        }).toList(),
      );

    return Expanded(
      flex: 1,
      child: dropdownFormField,
    );
  }
}

// This is a test
class AppDropdowns<T> extends StatelessWidget {
  final String hint;
  final FormFieldSetter<T> onChanged;
  final List<T> sources;
  final Key key;
  T selectedValue;

  AppDropdowns({this.hint, T selectedValue, this.onChanged, this.sources, this.key});

  @override
  Widget build(BuildContext context) {
    print("build) dropdown $key, selectedLanguage $selectedValue");

    var dropdownButton = DropdownButton<T>(
      hint: Text(hint),
      key: key,
      value: selectedValue,
      onChanged: (value) {
        print("onChanged) dropdown $key, value $value");
        if (value != null) {
          selectedValue = value;
          print("widget.onChanged != null ? $onChanged");
          if (onChanged != null) {
            onChanged(value);
          }
        }
      },
      items: sources.map((i) {
        return DropdownMenuItem<T>(
          value: i,
          child: Text("$i"),
        );
      }).toList(),
    );

    return DropdownButtonHideUnderline(
      child: dropdownButton,
    );
  }
}

class AppDropdown<T> extends StatefulWidget {
  final String hint;
  final FormFieldSetter<T> onChanged;
  final List<T> sources;
  final Key key;
  T selectedValue;

  AppDropdown({this.hint, T selectedValue, this.onChanged, this.sources, this.key});

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState<T> extends State<AppDropdown> {
//  T selectedValue;

  @override
  Widget build(BuildContext context) {
    print("build) dropdown ${widget.key}, selectedValue ${widget.selectedValue}");

    var dropdownButton = DropdownButton<T>(
      hint: Text(widget.hint),
      key: widget.key,
      value: widget.selectedValue,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            widget.selectedValue = value;
          });
          print("widget.onChanged != null ? ${widget.onChanged}");
          if (widget.onChanged != null) {
            widget.onChanged(value);
          }
        }
      },
      items: widget.sources.map((i) {
        return DropdownMenuItem<T>(
          value: i,
          child: Text("$i"),
        );
      }).toList(),
    );

    return DropdownButtonHideUnderline(
      child: dropdownButton,
    );
  }
}