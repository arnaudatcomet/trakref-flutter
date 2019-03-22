import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class SupportTicketTextField extends StatelessWidget {
  String labeled = "This is an exemple";

  SupportTicketTextField(this.labeled);

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


class PageSupportTicketBloc extends FormField<SupportTicketTextField> {
  PageSupportTicketBloc({
    FormFieldSetter<SupportTicketTextField> onSaved,
    FormFieldValidator<SupportTicketTextField> validator,
    bool autovalidate = false
  }): super(
      onSaved: onSaved,
      validator: validator,
      builder: (FormFieldState<SupportTicketTextField> state) {
        return SafeArea(
          child: ListView(
            padding: EdgeInsets.all(30),
            children: <Widget>[
              ListTile(
                title: Text(
                    "Support",
                    style: TextStyle(
                        color: AppColors.gray,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: "SF Pro Text Regular"
                    )
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SupportTicketTextField('Issue Type'),
                  ),
                ],
              ),
              DropdownFormField<String>(
                validator: (value) {
                  if (value == null) {
                    return 'Required';
                  }
                },
                items: [
                  DropdownMenuItem<String>(
                    key: Key('SuggestionZDKey'),
                    child: Text('I have a new Trakref suggestion'),
                  ),
                  DropdownMenuItem<String>(
                    key: Key('NotWorkingZDKey'),
                    child: Text("Something isn't working right"),
                  ),
                  DropdownMenuItem<String>(
                    key: Key('NeedHelpZDKey'),
                    child: Text('I need help using Trakref'),
                  ),
                  DropdownMenuItem<String>(
                    key: Key('InterestedPurchaseZDKey'),
                    child: Text('I am interested in purchasing Trakref'),
                  ),
                  DropdownMenuItem<String>(
                    key: Key('RequestTrainingZDKey'),
                    child: Text('I would like to schedule a training'),
                  ),
                  DropdownMenuItem<String>(
                    key: Key('HelpEnteringZDKey'),
                    child: Text('I need help entering a service ticket'),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SupportTicketTextField('Email Address'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SupportTicketTextField('Phone Number'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SupportTicketTextField('Subject'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SupportTicketTextField('Description'),
                  ),
                ],
              ),
              AppButton(
                keyButton: Key('SubmitButton'),
                titleButton: "SUBMIT",
                onPressed: () {
                  print("This was pressed by Arnaud");
                },
              ),
              OutlineAppButton(
                keyButton: Key('CancelButton'),
                titleButton: "CANCEL",
                onPressed: () {
                  print("I pressed on the cancel button");
                },
              ), /*
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: new InkWell(
                      onTap: () => print("Forgot password"),
                      child: new Text("Cancel",
                          style: TextStyle(color: AppColors.gray)
                      )
                  ),
                ),
              )
              */
            ],
          ),
        );
      }
  );
}