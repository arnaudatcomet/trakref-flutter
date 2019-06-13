import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/screens/accounts/page_accounts_bloc.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAccountDetailBloc extends StatefulWidget {
  Account account;

  PageAccountDetailBloc({this.account});

  @override
  _PageAccountDetailBlocState createState() => _PageAccountDetailBlocState();
}

class _PageAccountDetailBlocState extends State<PageAccountDetailBloc> {

  @override
  void initState() {
    super.initState();
  }

  Widget buildTextfieldRow(String key, String label, String initialValue) {
    if (initialValue == null) {
      return Row(mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FormBuild.buildTextField(key: Key(key), label: label)
          ]
      );
    }
    return Row(mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FormBuild.buildTextField(key: Key(key), label: label, initialValue: initialValue)
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                TrakrefAPIService().getInstanceID().then((instanceID){
                  if (instanceID.isNotEmpty) {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PageAccountsBloc(
                            type: PageAccountsType.Details,
                          );
                        },
                        fullscreenDialog: true));
                  }
                  else {
                    print("No instanceID retrieved from successful login");
                  }
                });
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
                buildTextfieldRow("AccountNameKey", "Account Name", widget.account.name),
                buildTextfieldRow("IndustryTypeKey", "Industry Type", widget.account.industryType),
                buildTextfieldRow("StatusKey", "Status", widget.account.statusName),
                buildTextfieldRow("ContactNumberKey", "Contact Number", widget.account.contactPhone),
                buildTextfieldRow("ContactEmailKey", "Contact Email", widget.account.contactEmail),
              ],
            )
        )
    );
  }
}