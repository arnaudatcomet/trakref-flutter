import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_scan/barcode_scan.dart';


_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class PageSettingsScreens extends StatefulWidget {
  @override
  _PageSettingsScreensState createState() => _PageSettingsScreensState();
}

class _PageSettingsScreensState extends State<PageSettingsScreens> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _textFieldKey1 = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _textFieldKey2 = GlobalKey<FormFieldState<String>>();
  String barcode = "";
  bool _assignedtoMe = false;

  DateTime _currentDate;
  File _image;

  static const platform = const MethodChannel('flutter.native/zendesk');
  String _responseFromNativeCode = 'Waiting for Response...';

  // Scan a barcode with the camera
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }


  // Get an image from picker
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  // Call iOS native
  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('showZDChat');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }

    setState(() {
      _responseFromNativeCode = response;
    });
  }

  @override
  Widget build(BuildContext context) {
//    return LoadingWidget();
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextField(
                        key: _textFieldKey1,
                        decoration: InputDecoration(
                          labelText: 'This a textfield',
                          border: const UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        key: _textFieldKey2,
                        decoration: InputDecoration(
                          labelText: 'This a textfield',
                          border: const UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              PasswordField(
                fieldKey: _passwordFieldKey,
                helperText: 'No more than 8 characters.',
                labelText: 'Password',
                onFieldSubmitted: (String value) {
                  setState(() {
//                        person.password = value;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MaterialButton(
//                        onPressed: responseFromNativeCode,
//                        onPressed: _launchURL,
                        onPressed: scan,
                        height: 60,
                        color: AppColors.blueTurquoise,
//                        child: Text(_responseFromNativeCode,
    child: Text("Scan",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "SF Pro Text Regular"
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: MaterialButton(
                        height: 60,
                        child: Text('CANCEL',
                            style: TextStyle(
                                color: AppColors.blueTurquoise,
                                fontSize: 16,
                                fontFamily: "SF Pro Text"
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Install date',
                      border: const UnderlineInputBorder(),
                      suffixIcon: new IconButton(icon: new Image.asset('assets/images/calendar.png', height: 22),
                          onPressed: null)
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Serial number',
                      border: const UnderlineInputBorder(),
                      suffixIcon: new IconButton(icon: new Image.asset('assets/images/barcode-icon.png', height: 22),
                          onPressed: () {
                        getImage();
                          })
                  ),
                ),
              ),
              DropdownFormField<String>(
                validator: (value) {
                  if (value == null) {
                    return 'Required';
                  }
                },
                onSaved: (value) {
                  // ...
                },
                decoration: InputDecoration(
                  filled: false,
                  labelText: 'Favorite Leak Test Method',
                ),
                initialValue: null,
                items: [
                  DropdownMenuItem<String>(
                    value: 'ALD',
                    child: Text('ALD'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Alternative',
                    child: Text('Alternative'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Bubble Test',
                    child: Text('Bubble Test'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Dye Inject',
                    child: Text('Dye Inject'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Electronic Ultrasonic',
                    child: Text('Electronic Ultrasonic'),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: CalendarCarousel(
                  todayTextStyle: Theme.of(context).textTheme.display1,
                  iconColor: AppColors.blueTurquoise,
                  onDayPressed: (DateTime date, List<String> events) {
                    this.setState(() => _currentDate = date);
                  },
                  thisMonthDayBorderColor: Colors.grey,
                  height: 420.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: true,
                  weekdayTextStyle: TextStyle(
                      color: AppColors.blueTurquoise,
                      fontWeight: FontWeight.bold
                  ),
                  headerTextStyle: TextStyle(
                      color: AppColors.lightGray
                  ),
                  inactiveDaysTextStyle: TextStyle(
                      color: AppColors.lightGray
                  ),
                  daysTextStyle: TextStyle(
                      color: AppColors.gray,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Password
class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.maxLength,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final int maxLength;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: (widget.maxLength == 0) ? null : widget.maxLength,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            semanticLabel: _obscureText ? 'show password' : 'hide password',
          ),
        )
      ),
    );
  }
}

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