import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/viewmodel/profile_model.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/models/info_user.dart';

class PageProfileDetailBloc extends StatefulWidget {

  @override
  _PageProfileDetailBloc createState() => _PageProfileDetailBloc();
}

class _PageProfileDetailBloc extends State<PageProfileDetailBloc> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileModel>(
      onModelReady: (model) => model.fetchProfile(),
      builder: (context, model, child) {
        return (model.state == ViewState.Busy) ? FormBuild.buildLoader():
        Scaffold(
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
            child: buildInfo(context, model.currentProfile)
        )
    );
      },
    );
  }
}