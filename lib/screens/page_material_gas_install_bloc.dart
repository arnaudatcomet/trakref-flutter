import "package:flutter/material.dart";
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

enum MaterialGasInstallType { Recovery, Install }

class PageMaterialGasInstallBloc extends StatefulWidget {
  List<Asset> assets = [];
  Asset currentAssetWorkedOn;
  MaterialGasInstallType installType;

  PageMaterialGasInstallBloc({this.assets, this.currentAssetWorkedOn, this.installType});

  @override
  _PageMaterialGasInstallBlocState createState() => _PageMaterialGasInstallBlocState();
}

class _PageMaterialGasInstallBlocState extends State<PageMaterialGasInstallBloc> {
  Asset _pickedAsset;

  String getTitle(MaterialGasInstallType type) {
    if (type == MaterialGasInstallType.Install) {
      return "Install";
    }
    else if (type == MaterialGasInstallType.Recovery) {
      return "Recovery";
    }
    return null;
  }

  String getActionButtonTitle(MaterialGasInstallType type) {
    if (type == MaterialGasInstallType.Install) {
      return "ADD INSTALL";
    }
    else if (type == MaterialGasInstallType.Recovery) {
      return "ADD RECOVERY";
    }
    return "SUBMIT";
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTitle(context),
          SizedBox(
            height: 10,
          ),
          _buildInstallGasHeader(context, widget.currentAssetWorkedOn),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormBuild.buildDropdown(isRequired: true,
                  key: Key("SelectedCylinder"),
                  source: (widget.assets ?? []).map((i) =>
                      Dropdown(
                          name: i.name,
                          id: i.assetID
                      )
                  ).toList(),
                  label: "Select Cylinder",
                  onValidator: (value) {
                    if (_pickedAsset == null) {
                      return "Required";
                    }
                  },
                  onChangedValue: (value) {
                    if (value is Dropdown) {
                      print(
                          "Select Cylinder > onChangedValue ${value.name} / ${value
                              .id}");
                    }
                    Asset selectedAsset = Asset(
                        assetID: (value is Dropdown) ? value.id : 0);
                    int pickedIndex = widget.assets.indexOf(selectedAsset);
                    Asset fullSelectedAsset = widget.assets[pickedIndex];
                    setState(() {
                      _pickedAsset = fullSelectedAsset;
                    });
                  }
              )
            ],
          ),
          _buildInstallAmount(context),
          _buildInstallGasHeader(context, _pickedAsset),
          // Need to put at the bottom
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottom(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInstallAmount(BuildContext context) {
    return Row(
      children: <Widget>[
        FormBuild.buildTextField(key: Key("ChooseAmountInKey"), label: "Choose Amount (lbs)", inputType: TextInputType.number)
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: AppButton(
                    titleButton: getActionButtonTitle(widget.installType),
                    onPressed: () {
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
  Widget _buildTitle(BuildContext context) {
    return Container(
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Text(
                "Gas ${getTitle(widget.installType)}",
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .title.copyWith(
                  color: AppColors.blueTurquoise
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _buildInstallGasHeader(BuildContext context, Asset selectedAsset) {
    print("_buildInstallGasHeader");
    return Align(
      alignment: Alignment.topLeft,
      child: (selectedAsset == null) ? Container() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                    "Material type: ", style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                    fontWeight: FontWeight.bold
                )
                ),
                Text(
                    "${selectedAsset.materialType}", style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                    fontStyle: FontStyle.italic
                )
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                    "Max gas capacity: ", style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                    fontWeight: FontWeight.bold
                )
                ),
                Text(
                    "${selectedAsset.maxGasCapacityLbs} ${selectedAsset.weightUnits ?? "Lbs"}", style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                    fontStyle: FontStyle.italic
                )
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                    "Current gas capacity: ", style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                    fontWeight: FontWeight.bold
                )
                ),
                Text(
                    "${selectedAsset.currentGasWeightLbs} ${selectedAsset.weightUnits ?? "Lbs"}", style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .copyWith(
                    fontStyle: FontStyle.italic
                )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // child: _buildOverlayContent(context),
  @override
  Widget build(BuildContext context) {
    return _buildOverlayContent(context);
  }
}
