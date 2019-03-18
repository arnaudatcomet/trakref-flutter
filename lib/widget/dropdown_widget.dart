import 'package:flutter/material.dart';

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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: field.value,
                isDense: true,
                onChanged: field.didChange,
                items: items.toList(),
              ),
            ),
          )
      );
    },
  );
}