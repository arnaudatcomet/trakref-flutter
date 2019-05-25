import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageCylinderDetailBloc extends StatefulWidget {
  Asset asset;

  PageCylinderDetailBloc({this.asset});

  @override
  _PageCylinderDetailBlocState createState() => _PageCylinderDetailBlocState();
}

class _PageCylinderDetailBlocState extends State<PageCylinderDetailBloc> {

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
                        child: Text("Asset Details",
                          style: Theme.of(context).textTheme.title,
                        )
                    )
                  ],
                ),
                FormBuild.buildTextfieldRow("SystemNameKey", "System Name", widget.asset.name, enabled: false),
                FormBuild.buildTextfieldRow("SerialNumberKey", "Serial Number", widget.asset.serialNumber, enabled: false),
                FormBuild.buildTextfieldRow("TagNumberKey", "Tag Number", widget.asset.tagNumber, enabled: false),
                FormBuild.buildTextfieldRow("CategoryKey", "Category", widget.asset.assetCategory, enabled: false),
                FormBuild.buildTextfieldRow("SystemTypeKey", "System Type", widget.asset.assetType, enabled: false),
                FormBuild.buildTextfieldRow("PONumberKey", "PO Number", widget.asset.poNumber, enabled: false),
                FormBuild.buildTextfieldRow("SystemStatusKey", "System Status", ((widget.asset.assetStatusID == 0) ? "Closed" : "Opened"), enabled: false),
                FormBuild.buildTextfieldRow("ClientNameKey", "Refrigerant Type", widget.asset.materialType, enabled: false),
                FormBuild.buildTextfieldRow("ContactNumberKey", "Max Gas Weight", widget.asset.maxGasCapacityLbs.toString(), enabled: false),
                FormBuild.buildTextfieldRow("ContactEmailKey", "Current Gas Weight", widget.asset.currentGasWeightLbs.toString(), enabled: false)
              ],
            )
        )
    );
  }
}
