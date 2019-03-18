import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class ProfileTextField extends StatelessWidget {
  String labeled = "This is an exemple";

  ProfileTextField(this.labeled);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            labelText: labeled,
            border: const UnderlineInputBorder()
        ),
      ),
    );
  }
}


class PageProfileBloc extends FormField<ProfileTextField> {
  PageProfileBloc({
    FormFieldSetter<ProfileTextField> onSaved,
    FormFieldValidator<ProfileTextField> validator,
    bool autovalidate = false
  }) : super(
      onSaved: onSaved,
      validator: validator,
      builder: (FormFieldState<ProfileTextField> state) {
        return SafeArea(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              ListTile(
                title: Text(
                  "Profile",
                  // Probably need to move that somewhere
                  style: TextStyle(
                      color: AppColors.gray,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "SF Pro Text Regular"
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ProfileTextField('Full Name'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ProfileTextField('Company'),
                  )
                ],
              ),

              DropdownFormField<String>(
                validator: (value) {
                  if (value == null) {
                    return 'Required';
                  }
                },
                decoration: InputDecoration(
                    filled: false,
                    labelText: 'Favorite Leak Test Method'
                ),
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
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ProfileTextField('Phone Number'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ProfileTextField('Email Address'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ProfileTextField('Certification Type'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ProfileTextField('Last 4 Numbers of Certificate'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: ButtonTheme(
                    height: 52.0,
                    child: new RaisedButton(
                      key: Key('SubmitButton'),
                      color: AppColors.blueTurquoise,
                      child: Text("Update", style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4),
                      ),
                    ),
                  ))
                ],
              )
            ],
          ),
        );
      });
}

