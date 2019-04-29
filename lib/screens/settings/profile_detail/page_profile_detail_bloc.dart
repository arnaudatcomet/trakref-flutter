import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/models/info_user.dart';

class PageProfileDetailBloc extends StatefulWidget {

  @override
  _PageProfileDetailBloc createState() => _PageProfileDetailBloc();
}

class _PageProfileDetailBloc extends State<PageProfileDetailBloc> {
  bool _isLoaded = false;
  InfoUser user = null;
  ApiService service = ApiService();

  @override
  void initState() {
    super.initState();

    final String loginURL = "https://api.trakref.com/v3.21/login";

    String username = 'echappell';
    String password = 'trakref';

    String basicAuth = 'Basic '+ base64Encode(utf8.encode('$username:$password'));
    final headers = {
      "authorization": basicAuth,
      "Api-Key": "eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0"
    };

    service.getLoginResponse(loginURL, username, password).then((response){
      print("infoUser ${response}");
      final res = response.body;
      dynamic resultMap = jsonDecode(res);
      InfoUser user = InfoUser.fromJson(resultMap);
      print("resultMap $resultMap");

      String fullName = user.user?.fullName;
      String company = user.user?.company;
      String preferredLeakDetectionMethod = user.user?.preferredLeakDetectionMethod;
      String phone = user.user?.phone;
      String email = user.user?.email;

      print("Fullname $fullName");
      print("Company $company");
      print("PreferredLeakDetectionMethod $preferredLeakDetectionMethod");
      print("Phone $phone");
      print("email $email");

      setState(() {
        this.user = user;
        _isLoaded = true;
      });
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
    service.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: (_isLoaded == false) ? FormBuild.buildLoader() : SafeArea(
            child: buildInfo(context, user)
        )
    );
  }
}