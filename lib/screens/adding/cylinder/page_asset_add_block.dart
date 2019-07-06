import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/screens/adding/app_cancellable_textfield_widget.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/viewmodel/cylinder_add_model.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAssetAddBloc extends StatefulWidget {
  PageAssetAddBloc();

  @override
  _PageAssetAddBlocState createState() => _PageAssetAddBlocState();
}

class _PageAssetAddBlocState extends State<PageAssetAddBloc> {
  // bool _isDropdownsLoaded = false;

  // Forms information
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Spacer
    SizedBox ColumnSpacer = SizedBox(
      width: 20,
    );

    return BaseView<CylinderAddModel>(
      onModelReady: (model) {
        model.fetchRespectiveDropdowns();
      },
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    print("Trying to validate the forms");
                    if (_formKey.currentState.validate()) {
                      print("the form '$_formKey is validated");
                      _formKey.currentState.save();
                      model.postCylinder(
                        onDone: () {
                          FormBuild.showFlushBarMessage(context, "Your appliance has been successfully added", () {
                            Navigator.pop(context);
                          });
                        },
                        onError: (error) {
                          FormBuild.showFlushBarMessage(context, "An error occurent : $error", null);
                        }
                      );
                    }
                  },
                  child: Text("Save",
                      style: TextStyle(color: AppColors.blueTurquoise)),
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
            body: (model.state == ViewState.Busy) ? FormBuild.buildLoader() : SafeArea(
                child: Form(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Add Cylinder",
                                      style: Theme.of(context).textTheme.title,
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FormBuild.buildTextField(
                                    key: Key("SystemNameKey"),
                                    textController: model.nameController,
                                    label: "Name",
                                    onValidated: (value) {
                                      return model.onValidate(model.nameController);
                                    },
                                    initialValue: null),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FormBuild.buildTextField(
                                    key: Key("CurrentGasWeightKey"),
                                    textController: model.currentGasWeightController,
                                    label: "Current Gas Weight",
                                    inputType: TextInputType.numberWithOptions(
                                        decimal: true),
                                    initialValue: null),
                                ColumnSpacer,
                                FormBuild.buildTextField(
                                    key: Key("MaxGasWeightKey"),
                                    textController: model.maxGasWeightController,
                                    label: "Max Gas Weight",
                                    inputType: TextInputType.numberWithOptions(
                                        decimal: true),
                                    initialValue: null),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                AppCancellableTextField(
                                    initialValue:
                                        model.pickedCoolingApplianceStatuses,
                                    sourcesDropdown:
                                        model.coolingApplianceStatuses,
                                    textKey: "ApplianceStatusKey",
                                    textLabel: "Appliance Status",
                                    textError: "Required",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedCoolingApplianceStatuses = value;
                                    })
                              ],
                            ),
                            Row(
                              // From dropdowns = assetTypes
                              children: <Widget>[
                                AppCancellableTextField(
                                    initialValue: model.pickedAssetTypes,
                                    sourcesDropdown: model.assetTypes,
                                    textKey: "ApplianceTypeKey",
                                    textLabel: "Appliance Type",
                                    textError: "Required",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedAssetTypes = value;
                                    })
                              ],
                            ),
                            Row(
                              // From dropdowns = assetSubTypes
                              children: <Widget>[
                                AppCancellableTextField(
                                    initialValue: model.pickedAssetSubTypes,
                                    sourcesDropdown: model.assetSubtypes,
                                    textKey: "ApplianceSubTypeKey",
                                    textLabel: "Appliance Sub Type",
                                    textError: "Required",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedAssetSubTypes = value;
                                    })
                              ],
                            ),
                            Row(
                              // From dropdowns = assetSubTypes
                              children: <Widget>[
                                AppCancellableTextField(
                                    initialValue: model.pickedAssetCategories,
                                    sourcesDropdown: model.assetCategories,
                                    textKey: "ApplianceCategoryKey",
                                    textLabel: "Appliance Category",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedAssetCategories = value;
                                    })
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                AppCancellableTextField(
                                    initialValue: model.pickedLocation,
                                    sourcesDropdown: model.locationsDropdowns,
                                    textKey: "LocationKey",
                                    textLabel: "Location",
                                    textError: "Required",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedLocation = value;
                                    }),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                AppCancellablePicker(
                                  textLabel: "Serial Number",
                                  textKey: "serialNumberImageKey",
                                  onChangedValue: (value) {
                                    print("onChangedValue $value");
                                    model.pickedSerialNumber = value;
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                AppCancellablePicker(
                                  textLabel: "Tag Number",
                                  textKey: "tagNumberImageKey",
                                  onChangedValue: (value) {
                                    print("onChangedValue $value");
                                    model.pickedTagNumber = value;
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                AppCancellableTextField(
                                    initialValue: model.pickedMaterialTypes,
                                    sourcesDropdown: model.materialType,
                                    textKey: "MaterialTypeKey",
                                    textLabel: "MaterialType",
                                    textError: "Required",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedMaterialTypes = value;
                                    })
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                // From dropdowns = cooling capacity
                                AppCancellableTextField(
                                    initialValue: model.pickedSystemStatuses,
                                    sourcesDropdown: model.systemStatuses,
                                    textKey: "SystemStatusesKey",
                                    textLabel: "System Status",
                                    textError: "Required",
                                    isRequired: true,
                                    onChangedValue: (value) {
                                      model.pickedSystemStatuses = value;
                                    }),
                              ],
                            ),
                          ],
                        ),
                        key: _formKey,
                      )));
      },
    );
  }
}
