import 'package:flutter/material.dart';
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
  }) : super(
    key: key,
    onSaved: onSaved,
    validator: validator,
    autovalidate: autovalidate,
    initialValue: items.contains(initialValue) ? initialValue : null,
    builder: (FormFieldState<T> field) {
      final InputDecoration effectiveDecoration = (decoration ?? const InputDecoration())
          .applyDefaults(Theme.of(field.context).inputDecorationTheme);

      return Container(
          child: InputDecorator(
            decoration:
            effectiveDecoration.copyWith(errorText: field.hasError ? field.errorText : null, fillColor: Colors.white),
            isEmpty: field.value == '' || field.value == null,
            child: Container(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  isExpanded: true,
                  value: field.value,
                  isDense: true,
                  onChanged: field.didChange,
                  items: items.toList(),
                ),
              ),
            ),
          )
      );
    },
  );
}

class FormBuild {
  // Convenient Loader
  static Widget buildLoader() {
    return Center(
      child: new CircularProgressIndicator(
          backgroundColor: Colors.red
      ),
    );
  }
  // To add a textfield quickly
  static Widget buildTextField({String label, Key key, TextInputType inputType}) {
    return Expanded(
      flex: 1,
      child: AppTextField(labeled: label, keyTextField: key, keyboardType: inputType),
    );
  }

  static Widget buildImagePicker({String label, Key key, VoidCallback onPressed}) {
    return Expanded(
      flex: 1,
      child: ImagePickerTextField(labeled: label, onPressed: onPressed, keyImagePickerTextField: key,),
    );
  }

  static Widget buildDatePicker({String label, String helper, Key key, VoidCallback onPressed, DateTime startDate, DateTime endDate}) {
    return Expanded(
      flex: 1,
      child: DatePickerTextField(labeled: label, helper: helper, onPressed: onPressed, keyDatePickerTextField: key),
    );
  }

  static Widget buildDropdown<T>(List<T> source, String label,
  {FormFieldSetter<T> onSaved}) {
    if (source == null) {
      print("Buid dropdown for '$label' is empty!");
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.yellow,
        ),
      );
    }
    int count = source.length;
    print("Buid dropdown for '$label' with count '$count'");
    if (source.length == 0) {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.red,
        ),
      );
    }
    if (source is List<Dropdown>) {
      return Expanded(
        flex: 1,
        child: DropdownFormField<String>(
          decoration: InputDecoration(labelText: label),
          items: source.map((i) {
            if (i is Dropdown) {
              Dropdown dropdown = i;
              String name = dropdown.name;
              return DropdownMenuItem<String>(
                value: name,
                  child: Text('$name')
              );
            }
            return DropdownMenuItem<String>(
              value: "",
              child: Text(""),
            );
          }).toList(),
        ),
      );
    }

    // Do nothing
    return Expanded(
      flex: 1,
      child: Container(),
    );
  }
}