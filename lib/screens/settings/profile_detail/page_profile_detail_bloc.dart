import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/models/info_user.dart';

class PageProfileDetailBloc extends StatefulWidget {

  @override
  _PageProfileDetailBloc createState() => _PageProfileDetailBloc();
}

class _PageProfileDetailBloc extends State<PageProfileDetailBloc> {
  InfoUser user;
  TrakrefAPIService api = TrakrefAPIService();

  @override
  void initState() {
    super.initState();

    // Grab the user from sharedpreferences
    api.getSelectedProfile().then((infoUser){
      setState(() {
        user = infoUser;
      });

      if (infoUser == null) {
        print("infoUser is empty!");
      }
      else {
        print("infoUser ${user}");
        print("infoUser.user ${user.user}");
        print("FullNameKey ${user.user?.fullName}");
        print("CompanyKey ${user.user?.company}");
        print("FavoriteLeakTestMethodKey ${user.user?.preferredLeakDetectionMethod}");
        print("PhoneNumberKey ${user.user?.phone}");
      }

    });
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

  Widget buildInfo(BuildContext context, InfoUser user) {
    return (user == null) ? Container() : ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Text("My Profile",
                  style: Theme.of(context).textTheme.title,
                )
            )
          ],
        ),
        buildTextfieldRow("FullNameKey", "Full Name", user.user?.fullName),
        buildTextfieldRow("CompanyKey", "Company", user.user?.company),
        buildTextfieldRow("FavoriteLeakTestMethodKey", "Favorite Leak Test Method", user.user?.preferredLeakDetectionMethod),
        buildTextfieldRow("PhoneNumberKey", "Phone Number", user.user?.phone),
        buildTextfieldRow("EmailKey", "Email Address", user.user?.email),
        buildTextfieldRow("CertificationTypeKey", "Certification Type", user.user?.certificationType),
        buildTextfieldRow("CertificationNumberKey", "Certification Number", user.user?.certificateNumber),
      ],
    );
  }

  @override
  void dispose() {
    api.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
            child: buildInfo(context, user)
        )
    );
  }
}