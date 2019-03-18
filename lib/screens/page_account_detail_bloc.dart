import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

class AccountDetailTextField extends StatelessWidget {
  String labeled = "This is an exemple";

  AccountDetailTextField(this.labeled);

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

class PageAccountDetailBloc extends FormField<AccountDetailTextField> {
  PageAccountDetailBloc({
    FormFieldSetter<AccountDetailTextField> onSaved,
    FormFieldValidator<AccountDetailTextField> validator,
    bool autovalidate = false
}): super(
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<AccountDetailTextField> state) {
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            ListTile(
              title: Text(
                "Account Details",
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
                  child: AccountDetailTextField('Account Name'),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AccountDetailTextField('Industry Type'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AccountDetailTextField('Status'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AccountDetailTextField('Contact Number'),
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
                  child: AccountDetailTextField('Contact Email'),
                )
              ],
            )
          ],
        ),
      );
    }
  );
}