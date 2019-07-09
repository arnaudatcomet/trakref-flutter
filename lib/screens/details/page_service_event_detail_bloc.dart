import 'package:flutter/material.dart';
import 'package:trakref_app/helper.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

// PageWorkOrderDetailBloc
typedef PageServiceEventDetailDelegate = Widget Function();

class PageServiceEventDetailBloc extends StatefulWidget {
  final WorkItem serviceEvent;

  PageServiceEventDetailBloc({this.serviceEvent});

  @override
  _PageServiceEventDetailBlocState createState() =>
      _PageServiceEventDetailBlocState();
}

class _PageServiceEventDetailBlocState extends State<PageServiceEventDetailBloc>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> buildMaterialTransfer(MaterialTransfer transfer) {
    List<Widget> leakInspection = [
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Transfer Type", transfer.materialTransferType,
                enabled: false),
            flex: 1,
          ),
          Icon(Icons.person, color: AppColors.blueTurquoise),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Technician Name", transfer.technicianName,
                enabled: false),
            flex: 1,
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "From Location", transfer.fromLocation,
                enabled: false),
            flex: 1,
          ),
          Icon(Icons.shuffle, color: AppColors.blueTurquoise),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "To Location", transfer.toLocation,
                enabled: false),
            flex: 1,
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "From Asset", transfer.fromAsset ?? "Unknown",
                enabled: false),
            flex: 1,
          ),
          Icon(Icons.shuffle, color: AppColors.blueTurquoise),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "To Asset", transfer.toAsset ?? "Unknown",
                enabled: false),
            flex: 1,
          )
        ],
      ),
      FormBuild.buildTextfieldRow(
          "", "Transfer Weight", transfer.transferWeightLbs.toString(),
          enabled: false),
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
                "", "Leak Inspection", leak.leakInspectionType,
                enabled: false),
            flex: 1,
          ),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Detection Method", leak.leakDetectionMethod,
                enabled: false),
            flex: 1,
          )
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Leak Category", leak.leakLocationCategory,
                enabled: false),
            flex: 1,
          ),
          Expanded(
            child: FormBuild.buildTextfieldRow(
                "", "Leak Location", leak.leakLocation,
                enabled: false),
            flex: 1,
          )
        ],
      ),
      FormBuild.buildTextfieldRow("", "Fault Cause Type", leak.faultCauseType,
          enabled: false),
    ];

    return [
      Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: FormBuild.buildTinyTextField(
                        initialValue: leak.leakInspectionType,
                        label: "Leak Inspection"),
                  ),
                  Expanded(
                    child: FormBuild.buildTinyTextField(
                        initialValue: (leak.wasLeakFound) ? "True" : "False",
                        label: "Was Leak Found?"),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: FormBuild.buildTinyTextField(
                        initialValue: leak.leakLocationCategory,
                        label: "Leak Location Category"),
                  ),
                  Expanded(
                    child: FormBuild.buildTinyTextField(
                        initialValue: leak.leakLocation, label: "Leak Location"),
                  )
                ],
              ),
              FormBuild.buildTinyTextField(
                  initialValue: leak.faultCauseType, label: "Fault Cause Type"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: FormBuild.buildTinyTextField(
                        initialValue: "${leak.estimatedLeakAmount} lbs",
                        label: "Estimated Leak Amount"),
                  ),
                  Expanded(
                    child: FormBuild.buildTinyTextField(
                        initialValue: Helper.getShortDate(leak.inspectionDate), label: "Inspection Date"),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    ];
    //   Container(
    //     decoration: new BoxDecoration(
    //       color: Colors.white,
    //       shape: BoxShape.rectangle,
    //       borderRadius: new BorderRadius.circular(12.0),
    //       boxShadow: <BoxShadow>[
    //         BoxShadow(
    //             color: Colors.black,
    //             blurRadius: 3.0,
    //             offset: const Offset(0.0, 2.0))
    //       ],
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(12),
    //       child: Column(
    //         children: <Widget>[...leakInspection],
    //       ),
    //     ),
    //   )
    // ];
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Create widget for the dates
    Widget ServiceDateWidget = FormBuild.buildTextField(
        label: "Service Date",
        key: Key("ServiceDateKey"),
        initialValue: Helper.getShortDate(widget.serviceEvent.serviceDate) ??
            "Non available",
        enabled: false);

    Widget FollowUpDateWidget = FormBuild.buildTextField(
        label: "Follow Up Date",
        key: Key("FollowUpDateKey"),
        initialValue:
            Helper.getShortDate(widget.serviceEvent.dateOfFollowUpService) ??
                "Non available",
        enabled: false);

    // Build service event header
    List<Widget> serviceEventHeader = [
      FormBuild.buildTextfieldRow("ServiceEventNumber", "Service Event #",
          widget.serviceEvent.workItemID.toString(),
          enabled: false),
      FormBuild.buildTextfieldRow(
          "AssetLocationKey", "Location", widget.serviceEvent.assetLocation,
          enabled: false),
      FormBuild.buildTextfieldRow(
          "AssetKey", "Equipment working on", widget.serviceEvent.asset,
          enabled: false),
      FormBuild.buildTextfieldRow(
          "MaterialTypeKey", "Material Type", widget.serviceEvent.materialType,
          enabled: false),
      FormBuild.buildTextfieldRow("LeakRepairedKey", "Leak Repair",
          widget.serviceEvent.leakRepairDispositionType,
          enabled: false),
      FormBuild.buildTextfieldRow("ServiceTransferReasonKey",
          "Service Transfer Reason", widget.serviceEvent.serviceTransferReason,
          enabled: false),
      FormBuild.buildTextfieldRow("ServiceActionKey", "Service Action",
          widget.serviceEvent.serviceAction,
          enabled: false),
      Row(
        children: <Widget>[ServiceDateWidget, FollowUpDateWidget],
      ),
      FormBuild.buildTextfieldRow(
          "RepairNotesKey", "Repair Notes", widget.serviceEvent.repairNotes,
          enabled: false),
      SizedBox(
        height: 20,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.gray,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: 'service-event-${widget.serviceEvent.workItemID}',
                      child: Text("${widget.serviceEvent.workItemType}",
                          style: Theme.of(context).textTheme.title),
                    ),
                  ],
                ),
              ),
              TabBar(
                labelColor: AppColors.blueTurquoise,
                unselectedLabelColor: AppColors.gray,
                controller: _tabController,
                indicatorColor: AppColors.blueTurquoise,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: <Widget>[
                  Tab(
                    text: 'Information',
                  ),
                  Tab(
                    text: 'Leak Inspection',
                  ),
                  Tab(
                    text: 'Gas Transfer',
                  )
                ],
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[
                    SingleChildScrollView(
                        child: Column(
                      children: <Widget>[...serviceEventHeader],
                    )),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[...leaks],
                      ),
                    ),
                    Container(color: Colors.green),
                  ],
                ),
              ))
            ] /* SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'service-event-${widget.serviceEvent.workItemID}',
                    child: Text("${widget.serviceEvent.workItemType}",
                        style: Theme.of(context).textTheme.title),
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
            ])) */
            ,
          ),
        ));
  }
}
