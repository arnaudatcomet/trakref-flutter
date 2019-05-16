import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';

class AppOutlineButton extends StatelessWidget {
  String title;
  Function onPressed;
  AppOutlineButton({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
          child: Text(
            title ?? "",
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontFamily: 'SF Pro Text Regular',
            ),
          ),
          onPressed: () => onPressed(),
          borderSide: BorderSide(
              color: AppColors.lightGray,
              width: 0.3
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          )
      );
  }
}

class LinkAppButton extends StatefulWidget {
  Function onPressed;
  String title;
  TextStyle style;

  LinkAppButton({this.onPressed, this.title, this.style});

  @override
  _LinkAppButtonState createState() => _LinkAppButtonState();
}

class _LinkAppButtonState extends State<LinkAppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      alignment: Alignment.center,
      child: new InkWell(
          onTap: widget.onPressed,
          child: new Text(widget.title ?? "",
            style: widget.style,
          )
      ),
    );
  }
}

class OutlineAppButton extends AppButton {
  OutlineAppButton({
    Key keyButton,
    String titleButton,
    @required VoidCallback onPressed
  }):super(
    keyButton: keyButton,
    onPressed: onPressed,
    titleButton: titleButton
  );

  @override
  _OutlineAppButtonState createState() => _OutlineAppButtonState();
}

class _OutlineAppButtonState extends _AppButtonState {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: new InkWell(
            onTap: widget.onPressed,
            child: new Text(widget.titleButton ?? "",
                style: TextStyle(color: AppColors.gray)
            )
        ),
      ),
    );
  }
}

class AppButton extends StatefulWidget {
  final Key keyButton;
  final String titleButton;
  final Color buttonColor = AppColors.blueTurquoise;
  @required
  final VoidCallback onPressed;

  AppButton({this.keyButton, this.titleButton ,this.onPressed});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 52.0,
      child: new RaisedButton(
        key: widget.keyButton ?? Key("DefaultKey"),
        color: AppColors.blueTurquoise,
        child: Text(widget.titleButton ?? "SUBMIT", style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: widget.onPressed,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(4),
        ),
      ),
    );
  }
}

// Generic textfield for forms
class AppTextField extends StatefulWidget {
  Key keyTextField;
  String labeled = "This is a textfield example";
  VoidCallback onEditingComplete;
  ValueChanged<String> onValidated;
  ValueChanged<String> onSubmitted;
  ValueChanged<String> onChanged;
  TextInputType keyboardType;
  TextEditingController textController;
  String initialValue;
  bool enabled;
  AppTextField({
    this.keyTextField, this.onValidated, this.textController, this.onChanged, this.keyboardType, this.labeled, this.initialValue, this.onEditingComplete, this.onSubmitted, this.enabled});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  @override
  void initState() {
    widget.textController.addListener(onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.textController.removeListener(onTextChanged);
    super.dispose();
  }

  void onTextChanged() {
    print("onTextChanged > ${widget.textController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.textController,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        key: widget.keyTextField,
        onEditingComplete: widget.onEditingComplete,
        validator: widget.onValidated,
        onFieldSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
            labelText: widget.labeled ?? "",
            border: const UnderlineInputBorder()
        ),
      ),
    );
  }
}

// Image picker for textfield
class ImagePickerTextField extends StatefulWidget {
  VoidCallback onPressed;
  String labeled = "This is an imagepicker example";
  Key keyImagePickerTextField;
  ValueChanged<String> onSubmitted;

  ImagePickerTextField({this.onPressed, this.labeled,
    this.keyImagePickerTextField, this.onSubmitted});

  @override
  _ImagePickerTextFieldState createState() => _ImagePickerTextFieldState();
}

class _ImagePickerTextFieldState extends State<ImagePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: TextField(
        decoration: InputDecoration(
            labelText: widget.labeled,
            border: const UnderlineInputBorder(),
            suffixIcon: new IconButton(icon: Image.asset('assets/images/barcode-icon.png',
                colorBlendMode: BlendMode.color,
                color: AppColors.blueTurquoise,
                height: 22),
                onPressed: widget.onPressed)
        ),
      ),
    );
  }
}


// Image picker for textfield
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class DatePickerTextField extends StatefulWidget {
  final ValueChanged<DateTime> onPressed;
  final ValueChanged<String> onValidated;
  String labeled = "";
  String helper = "";
  Key keyDatePickerTextField;
  ValueChanged<String> onSubmitted;

  DatePickerTextField({this.onPressed, this.onValidated, this.labeled, this.helper,
    this.keyDatePickerTextField});

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  DateTime _date;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2020));
    setState(() {
      _date = picked;
      widget.onPressed(_date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: TextFormField(
        enableInteractiveSelection: false,
        focusNode: AlwaysDisabledFocusNode(),
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.onValidated,
//        onSubmitted: widget.onSubmitted,
//        onTap: () {
//
//        },
        decoration: InputDecoration(
            helperText: widget.helper,
            labelText: (_date == null) ? "" : DateFormat(kShortReadableDateFormat).format(_date),
            border: const UnderlineInputBorder(),
            suffixIcon: new IconButton(icon: Image.asset('assets/images/calendar.png',
//                colorBlendMode: BlendMode.color,
                color: AppColors.blueTurquoise,
                height: 22),
                onPressed: () {
                  _selectDate(context);
                })
        ),
      ),
    );
  }
}

// A text button
class TextButton extends StatelessWidget {
  Function onPressed;
  String title;
  FontWeight fontWeight;
  Color color;

  TextButton({@required this.onPressed, this.title, this.fontWeight, this.color});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
        borderSide: BorderSide(
            color: Colors.white
        ),
        color: Colors.white,
        highlightColor: Colors.white,
        highlightedBorderColor: Colors.white,
        child: Text(title ?? "", style: Theme
            .of(context)
            .textTheme
            .display1
            .copyWith(
            color: color ?? AppColors.gray,
            fontWeight: fontWeight ?? FontWeight.normal
        )),
        onPressed: onPressed
    );
  }
}
