import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

class AppOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
          child: Text(
            'Filters',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontFamily: 'SF Pro Text Regular',
            ),
          ),
          onPressed: () => print('hello'),
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

class AppTextField extends StatefulWidget {
  Key keyTextField;
  String labeled = "This is a textfield example";
  VoidCallback onEditingComplete;
  ValueChanged<String> onSubmitted;

  AppTextField({
    this.keyTextField, this.labeled, this.onEditingComplete, this.onSubmitted});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: TextField(
        key: widget.keyTextField,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
            labelText: widget.labeled ?? "",
            border: const UnderlineInputBorder()
        ),
      ),
    );
  }
}