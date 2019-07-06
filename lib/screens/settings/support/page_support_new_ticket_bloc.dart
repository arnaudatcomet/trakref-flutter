import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/zdrequest.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/viewmodel/zendesk_support_model.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageSupportNewTicketBloc extends StatefulWidget {
  ZDRequestType type;

  PageSupportNewTicketBloc({this.type});

  @override
  _PageSupportNewTicketBlocState createState() =>
      _PageSupportNewTicketBlocState();
}

class _PageSupportNewTicketBlocState extends State<PageSupportNewTicketBloc> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ZendeskSupportModel>(
        onModelReady: (model) => model.fetchCurrentProfile(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
              ),
              body: (model.state == ViewState.Busy)
                  ? FormBuild.buildLoader()
                  : Form(
                      key: _formKey,
                      child: SafeArea(
                          child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: <Widget>[
                              new Container(
                                  width: double.infinity,
                                  child: new Text(
                                    "Support",
                                    style: Theme.of(context).textTheme.title,
                                    textAlign: TextAlign.left,
                                  )),
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              FormBuild.buildTextfieldRow(
                                  "IssueTypeKey",
                                  "Issue Type",
                                  ZDRequest.getRequestTypeFormattedString(
                                      widget.type),
                                  enabled: false),
                              Row(
                                children: <Widget>[
                                  FormBuild.buildTextField(
                                      textController:
                                          model.phoneNumberController,
                                      onValidated: (value) {
                                        if (value.isEmpty || value == null) {
                                          return "Required";
                                        }
                                      },
                                      inputType: TextInputType.text,
                                      key: Key("PhoneNumberKey"),
                                      label: "Phone Number"),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  FormBuild.buildTextField(
                                      textController: model.subjectController,
                                      onValidated: (value) {
                                        if (value.isEmpty || value == null) {
                                          return "Required";
                                        }
                                      },
                                      inputType: TextInputType.text,
                                      key: Key("SubjectKey"),
                                      label: "Subject"),
                                ],
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty || value == null) {
                                      return "Required";
                                    }
                                  },
                                  key: Key("ObservationKey"),
                                  maxLength: 50,
                                  maxLines: 10,
                                  controller: model.descriptionController,
                                  decoration: InputDecoration(
                                    helperText: "Description",
                                    fillColor: Colors.black.withAlpha(6),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        bottom: 10.0, left: 10.0, right: 10.0),
                                  ),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18)),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 30),
                                child: ButtonTheme(
                                  height: 52.0,
                                  child: new RaisedButton(
                                    key: Key('SubmitButton'),
                                    color: AppColors.blueTurquoise,
                                    child: (model.state == ViewState.Idle)
                                        ? Text("Submit".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16))
                                        : CircularProgressIndicator(
                                            strokeWidth: 1,
                                            backgroundColor: Colors.white),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        print("> validate");
                                        _formKey.currentState.save();
                                        model.submit(widget.type, onDone: () {
                                          FormBuild.showFlushBarMessage(context, "Your ticket has been posted, thanks", () {
                                            Navigator.of(context).pop();
                                          }, duration: 2);
                                        }, onError: (error) {
                                          FormBuild.showFlushBarMessage(context, "Something went wrong, please try again later", () {});
                                        });
                                      }
                                    },
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  OutlineAppButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    titleButton: "Cancel".toUpperCase(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                    ));
        });
  }
}
