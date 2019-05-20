import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/screens/adding/material_transfer/page_material_gas_install_bloc.dart';
import 'package:trakref_app/widget/button_widget.dart';

class MaterialTransfersWidget extends StatefulWidget {
  final List<MaterialTransfer> materialTransfers;
  final List<Asset> assets;
  final List<MaterialGasInstallType> allowedTransfers;
  int equipmentWorkedOnID;

  MaterialTransfersWidget({this.materialTransfers, this.allowedTransfers, this.assets, this.equipmentWorkedOnID});

  @override
  _MaterialTransfersWidgetState createState() => _MaterialTransfersWidgetState();
}

class _MaterialTransfersWidgetState extends State<MaterialTransfersWidget> {

  @override
  void initState() {
    super.initState();
  }
  // Show the modal for adding material gas
  void showAddMaterialModal(int equipmentWorkedOn, MaterialGasInstallType type) {
    if (equipmentWorkedOn != null) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            // Prepare the content for material gas
            Asset selectedAsset = Asset(
                assetID: equipmentWorkedOn
            );

            int pickedIndex = widget.assets.indexWhere((i) => i.assetID == equipmentWorkedOn);

            print("equipmentWorkedOn $equipmentWorkedOn");
            for (Asset asset in widget.assets) {
              print("================");
              print("name : ${asset.name}");
              print("asset : ${asset.assetID}");
            }

            print("pickedIndex : $pickedIndex");
            if (pickedIndex < 0) return Container();

            Asset picketAsset = widget.assets[pickedIndex];
            return new Container(
              color: Color(0xFF737373),
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
                  child: Container(
                    child: PageMaterialGasInstallBloc(
                      installType: type,
                      currentAssetWorkedOn: widget
                          .assets[pickedIndex],
                      assets: widget.assets,
                      delegate: (materialTransfer) {
                        print("materialTransfer > $materialTransfer");
                        print("materialTransferType > ${materialTransfer.materialTransferType}");
                        print("transferWeightLbs > ${materialTransfer.transferWeightLbs}");
                        print("fromAsset > ${materialTransfer.fromAsset}");
                        print("toAsset > ${materialTransfer.toAsset}");
                        widget.materialTransfers.add(materialTransfer);
                        setState(() {});
                      },
                    ),
                  )),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allowedTransfers.length == 0) {
      return Container();
    }

    List<Widget> materialColumns = [
      buildHeaderMaterialTransfer()
    ];
    int i = 0;
    for (MaterialTransfer transfer in widget.materialTransfers) {
      materialColumns.add(buildMaterialTransfer(transfer, i));
      i++;
    }
    materialColumns.add(buildBottomMaterialTransfer());

    return Column(
      children: materialColumns,
    );
  }

  Widget buildHeaderMaterialTransfer() {
    Widget jumpBox = SizedBox(
      height: 14,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        jumpBox,
        Text("Material Transfer",
            style: Theme.of(context)
                .textTheme
                .display2
                .copyWith(color: AppColors.blueTurquoise)),
        jumpBox,
      ],
    );
  }

  Widget buildBottomMaterialTransfer() {
    if (widget.allowedTransfers == null) {
      return Container();
    }

    List<Widget> buttons = [];
    for (MaterialGasInstallType type in widget.allowedTransfers) {
      Widget addInstallGasButton = AppOutlineButton(
        title: "Add ${MaterialTransfer.getMaterialGasTitle(type)}",
        onPressed: () {
          int pickedEquipmentWorked = widget.equipmentWorkedOnID;
          if (pickedEquipmentWorked != null) {
            showAddMaterialModal(pickedEquipmentWorked, type);
          }
        },
      );
      Widget separator = SizedBox(
        width: 20,
      );
      buttons.add(addInstallGasButton);
      buttons.add(separator);
    }

    return Row(
      children: <Widget>[
        Spacer(),
        ...buttons,
        Spacer()
      ],
    );

    return Row(
      children: <Widget>[
        Spacer(),
        AppOutlineButton(
          title: "Add Install",
          onPressed: () {
            int pickedEquipmentWorked = widget.equipmentWorkedOnID;
            if (pickedEquipmentWorked != null) {
              showAddMaterialModal(pickedEquipmentWorked, MaterialGasInstallType.Install);
            }
          },
        ),
        SizedBox(
          width: 20,
        ),
        AppOutlineButton(
          title: "Add Recovery",
          onPressed: () {
            int pickedEquipmentWorked = widget.equipmentWorkedOnID;
            if (pickedEquipmentWorked != null) {
              showAddMaterialModal(pickedEquipmentWorked, MaterialGasInstallType.Recovery);
            }
          },
        ),
        Spacer()
      ],
    );
  }

  String concatenateAsset(String assetName, int maxLength) {
    String fromAsset = assetName ?? "Unknown";
    if (fromAsset.length > maxLength) {
      print("fromAsset.length ${fromAsset.length}");
      print("maxLength $maxLength");
      fromAsset = fromAsset.substring(0, maxLength);
    }
    return fromAsset;
  }

  Widget buildMaterialTransfer(MaterialTransfer transfer, int index) {
    int currentIndex = index;
    final materialTransferThumbnail = Container(
      alignment: const FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 8.0),
      child: CircleAvatar(
        radius: 44,
        backgroundColor: AppColors.blueTurquoise,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("lbs", style: TextStyle(
                color: Colors.white,
                fontSize: 12
            )),
            Text("${transfer.transferWeightLbs}", style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon((transfer.materialTransferTypeID == MaterialTransfer.serviceRecoveryID()) ? Icons.file_upload : Icons.file_download,
                  size: 14,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Material transfer formatted date
    String materialTransferDate;
    if (transfer.transferDate != null) {
      materialTransferDate = DateFormat(kShortDateFormat).format(DateFormat(kShortTimeDateFormat).parse(transfer.transferDate));
    }

    const int maxAssetNameLength = 13;

    final materialTransferCard = Container(
      margin: const EdgeInsets.only(left: 54.0, right: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(12.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black,
              blurRadius: 3.0,
              offset: const Offset(0.0, 2.0))
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 50.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("${transfer.materialTransferType ?? ""}", style: Theme
                    .of(context)
                    .textTheme
                    .display2
                    .copyWith(
                    color: AppColors.blueTurquoise
                )),
                SizedBox(
                    width: 6
                )
              ],
            ),
            Row(
              children: <Widget>[
                /*
                Text("${transfer.fromAsset.substring(0, maxAssetNameLength)}..." ?? "Unknown", style: Theme
                    .of(context)
                    .textTheme
                    .display4),
                Icon(Icons.arrow_right, color: AppColors.blueTurquoise),
                Text("${transfer.toAsset?.substring(0, maxAssetNameLength) ?? "Unknown"}", style: Theme
                    .of(context)
                    .textTheme
                    .display4)
                    */
//                concatenateAsset
                Text("${concatenateAsset(transfer.fromAsset, maxAssetNameLength)}", style: Theme
                    .of(context)
                    .textTheme
                    .display4),
                Icon(Icons.arrow_right, color: AppColors.blueTurquoise),
                Text("${concatenateAsset(transfer.toAsset, maxAssetNameLength)}", style: Theme
                    .of(context)
                    .textTheme
                    .display4)
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.access_time, color: AppColors.blueTurquoise, size: 14),
                Text(materialTransferDate ?? "Undefined", style: Theme
                    .of(context)
                    .textTheme
                    .display4)
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: <Widget>[
                  Icon(Icons.remove_circle, color: Colors.red),
                Text("Tap to remove transfer", style: Theme.of(context).textTheme.display3.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
              ))
                ],
              ),
            )
          ],
        ),
      ),
    );

    return Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        onPressed: () {
          widget.materialTransfers.removeAt(currentIndex);
          setState(() {
          });
        },
        child: new Stack(
          children: <Widget>[
            materialTransferCard,
            materialTransferThumbnail,
          ],
        ),
      ),
    );
  }
}
