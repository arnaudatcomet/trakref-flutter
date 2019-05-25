import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

// PageWorkOrderDetailBloc
typedef PageServiceEventDetailDelegate = Widget Function();

class PageServiceEventDetailBloc extends StatefulWidget {
  WorkItem serviceEvent;
  PageServiceEventDetailDelegate delegate;

  PageServiceEventDetailBloc({this.serviceEvent, this.delegate});

  @override
  _PageServiceEventDetailBlocState createState() =>
      _PageServiceEventDetailBlocState();
}

class _PageServiceEventDetailBlocState
    extends State<PageServiceEventDetailBloc> {
  List<Widget> buildMaterialTransfer(MaterialTransfer transfer) {
    List<Widget> leakInspection = [
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Transfer Type", transfer.materialTransferType, enabled: false),
            flex: 1,
          ),
          Icon(Icons.person, color: AppColors.blueTurquoise),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Technician Name", transfer.technicianName, enabled: false),
            flex: 1,
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "From Location", transfer.fromLocation, enabled: false),
            flex: 1,
          ),
          Icon(Icons.shuffle, color: AppColors.blueTurquoise),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "To Location", transfer.toLocation, enabled: false),
            flex: 1,
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "From Asset", transfer.fromAsset, enabled: false),
            flex: 1,
          ),
          Icon(Icons.shuffle, color: AppColors.blueTurquoise),
          Expanded(
            child:
                FormBuild.buildTextfieldRow("", "To Asset", transfer.toAsset, enabled: false),
            flex: 1,
          )
        ],
      ),
      FormBuild.buildTextfieldRow(
          "", "Transfer Weight", transfer.transferWeightLbs.toString(), enabled: false),
    ];

    return [
      Container(
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(12.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                blurRadius: 3.0,
                offset: const Offset(0.0, 2.0))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[...leakInspection],
          ),
        ),
      )
    ];
  }

  List<Widget> buildLeakInspection(LeakInspection leak) {
    List<Widget> leakInspection = [
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Leak Inspection", leak.leakInspectionType, enabled: false),
            flex: 1,
          ),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Detection Method", leak.leakDetectionMethod, enabled: false),
            flex: 1,
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Leak Category", leak.leakLocationCategory, enabled: false),
            flex: 1,
          ),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Leak Location", leak.leakLocation, enabled: false),
            flex: 1,
          )
        ],
      ),
      FormBuild.buildTextfieldRow("", "Fault Cause Type", leak.faultCauseType, enabled: false),
    ];

    return [
      Container(
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(12.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                blurRadius: 3.0,
                offset: const Offset(0.0, 2.0))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[...leakInspection],
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Build service event header
    List<Widget> serviceEventHeader = [
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow("", "Service Event #",
                widget.serviceEvent.workItemID.toString(), enabled: false),
            flex: 1,
          ),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Asset Location", widget.serviceEvent.assetLocation, enabled: false),
            flex: 1,
          )
        ],
      ),
      FormBuild.buildTextfieldRow("", "Service Transfer Reason",
          widget.serviceEvent.serviceTransferReason, enabled: false),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Material Type", widget.serviceEvent.materialType, enabled: false),
            flex: 1,
          ),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Service Action", widget.serviceEvent.serviceAction, enabled: false),
            flex: 1,
          )
        ],
      )
    ];

    // Build leak inspections
    List<Widget> leaks = [];
    for (LeakInspection leak in widget.serviceEvent.leakInspection) {
      leaks.addAll(buildLeakInspection(leak));
      leaks.addAll([
        SizedBox(height: 14),
      ]);
    }

    // Build material transfers
    List<Widget> materialTransfers = [];
    for (MaterialTransfer transfer in widget.serviceEvent.materialTransfer) {
      materialTransfers.addAll(buildMaterialTransfer(transfer));
      materialTransfers.addAll([
        SizedBox(height: 14),
      ]);
    }

    // Spacer
    Widget jumpBox = SizedBox(
      height: 14,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.gray,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.serviceEvent.workItemType.toUpperCase(),
          style: Theme.of(context).textTheme.display2,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'service-event-${widget.serviceEvent.workItemID}',
                    child: widget.delegate() ?? Container(),
                  ),
                ],
              ),
              ...serviceEventHeader,
              jumpBox,
              Text("Leak Inspection",
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(color: AppColors.blueTurquoise)),
              jumpBox,
              ...leaks,
              jumpBox,
              Text("Material Transfer",
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(color: AppColors.blueTurquoise)),
              jumpBox,
              ...materialTransfers,
              jumpBox
            ])),
      ),
    );
  }
}
