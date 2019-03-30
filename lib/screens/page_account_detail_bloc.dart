import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAccountDetailBloc extends StatefulWidget {
  String accountName;
  String industryType;
  String status;
  String contactNumber;
  String email;

  PageAccountDetailBloc({this.accountName, this.industryType, this.status,
    this.contactNumber, this.email});

  @override
  _PageAccountDetailBlocState createState() => _PageAccountDetailBlocState();
}

class _PageAccountDetailBlocState extends State<PageAccountDetailBloc> {

  @override
  void initState() {
    super.initState();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: () {

              },
              child: Text("Switch Account", style: TextStyle(
                  color: AppColors.blueTurquoise
              )),
            )
          ],
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: AppColors.gray),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.0),
        ),
        body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Text("Account Details",
                          style: Theme.of(context).textTheme.title,
                        )
                    )
                  ],
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FormBuild.buildTextField(key: Key("AccountNameKey"), label: "Account Name"),
                    ]
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FormBuild.buildTextField(key: Key("IndustryTypeKey"), label: "Industry Type"),
                    ]
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FormBuild.buildTextField(key: Key("StatusKey"), label: "Status"),
                    ]
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FormBuild.buildTextField(key: Key("ContactNumberKey"), label: "Contact Number"),
                    ]
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FormBuild.buildTextField(key: Key("ContactEmailKey"), label: "Contact Email"),
                    ]
                )
              ],
            )
        )
    );
  }
}

/*
class AccountDetailTextField extends StatelessWidget {
  String labeled = "This is an exemple";

  AccountDetailTextField({this.labeled});

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
                  child: AccountDetailTextField(labeled: 'Industry Type',),
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
*/