import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/get_service.dart';
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
          initialValue: items.contains(initialValue) ? initialValue : null,
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
                      print("onChanged) dropdown $key, value $value");
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
  // Convenient Loader
  static Widget buildLoader() {
    return Center(
      child: new CircularProgressIndicator(
          backgroundColor: Colors.white
      ),
    );
  }

  // To add a textfield quickly
  static Widget buildTextField({
    String label,
    Key key,
    TextInputType inputType,
    ValueChanged<String> onSubmitted,
    ValueChanged<String> onValidated
  }) {
    return Expanded(
      flex: 1,
      child: AppTextField(
        onValidated: onValidated,
        labeled: label,
        keyTextField: key,
        keyboardType: inputType,
        onSubmitted: onSubmitted,
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
    int count = source.length;
    if (source.length < 1) {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.red,
        ),
      );
    }

    print("buildDropdown $key > $source and initialValue $initialValue ");

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
        print("onChanged) dropdown ${key}, value $value");
        if (value != null) {
          selectedValue = value;
          print("widget.onChanged != null ? ${onChanged}");
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
        print("onChanged) dropdown ${widget.key}, value $value");
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