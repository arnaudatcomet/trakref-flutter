import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageLocationDetailBloc extends StatefulWidget {
  Location location;

  PageLocationDetailBloc({this.location});

  @override
  _PageLocationDetailBlocState createState() => _PageLocationDetailBlocState();
}

class _PageLocationDetailBlocState extends State<PageLocationDetailBloc> {
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Text("Location Details",
                          style: Theme.of(context).textTheme.title,
                        )
                    )
                  ],
                ),
                FormBuild.buildTextfieldRow("NameKey", "Name", widget.location.name),
                FormBuild.buildTextfieldRow("ContactKey", "Contact", "${widget.location.contactFirstName ?? ""} ${widget.location.contactLastName ?? ""}"),
                FormBuild.buildTextfieldRow("AddressKey", "Address", "${widget.location.mailingCity ?? ""} ${widget.location.mailingState ?? ""} ${widget.location.mailingZip ?? ""} ${widget.location.mailingCountry ?? ""}"),
                FormBuild.buildTextfieldRow("ContactPhoneKey", "Contact Number", widget.location.contactPhone ?? "")
              ],
            )
        )
    );
  }
}
