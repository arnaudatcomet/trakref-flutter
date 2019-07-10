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
    // All the styles for the form
    TextStyle bodyTextStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

    return [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2.0),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              offset: new Offset(0.0, 4.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Type : ${transfer.materialTransferType}",
                      textAlign: TextAlign.center,
                      style: bodyTextStyle,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormBuild.buildTinyTextField(
                        initialValue: transfer?.fromAsset ?? "Unknown",
                        label: "From Asset"),
                    Row(
                      children: <Widget>[
                        RotatedBox(
                            quarterTurns: 3, child: Icon(Icons.arrow_back)),
                        Chip(
                          label: Text(
                            "${transfer.transferWeightLbs} lbs",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: AppColors.blueTurquoise,
                        )
                      ],
                    ),
                    FormBuild.buildTinyTextField(
                        initialValue: transfer?.toAsset ?? "Unknown",
                        label: "To Asset:")
                  ],
                ),
                FormBuild.buildTinyTextField(
                    initialValue: transfer.fromLocation,
                    label: "From Location:"),
                FormBuild.buildTinyTextField(
                    initialValue: transfer.toLocation, label: "To Location:"),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: FormBuild.buildTinyTextField(
                            initialValue: transfer.technicianName,
                            label: "Technician Name")),
                    Expanded(
                      child: FormBuild.buildTinyTextField(
                          initialValue:
                              Helper.getShortDate(transfer.transferDate),
                          label: "Transfer Date"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> buildLeakInspection(LeakInspection leak) {
// All the styles for the form
    TextStyle bodyTextStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

    // Build the chip for the 'was leak found' and 'no leak found'
    Widget leakFoundStatusWidget = Container();
    if (leak.wasLeakFound != null) {
      if (leak.wasLeakFound == true) {
        leakFoundStatusWidget = Chip(
          label: Text(
            "Leak Found",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        );
      } else {
        leakFoundStatusWidget = Chip(
          label: Text(
            "No Leak Found",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.blueTurquoise,
        );
      }
    }
    return [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2.0),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              offset: new Offset(0.0, 4.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Type : ${leak.leakInspectionType}",
                      textAlign: TextAlign.center,
                      style: bodyTextStyle,
                    ),
                    SizedBox(width: 10),
                    leakFoundStatusWidget
                  ],
                ),
                FormBuild.buildTinyTextField(
                    initialValue: leak.leakLocationCategory,
                    label: "Leak Location Category"),
                FormBuild.buildTinyTextField(
                    initialValue: leak.leakLocation, label: "Leak Location"),
                FormBuild.buildTinyTextField(
                    initialValue: leak.faultCauseType,
                    label: "Fault Cause Type"),
                FormBuild.buildTinyTextField(
                    initialValue: "${leak.estimatedLeakAmount} lbs",
                    label: "Estimated Leak Amount"),
                Divider(),
                FormBuild.buildTinyTextField(
                    initialValue: (leak?.inspectionDate == null)
                        ? "Undefined"
                        : Helper.getShortDate(leak.inspectionDate),
                    label: "Inspection Date")
              ],
            ),
          ),
        ),
      )
    ];
  }

  @override
  void initState() {
    int tabBarSize = 3;
    switch (widget.serviceEvent.workItemTypeID) {
      case 2:
        tabBarSize = 2;
        break;
      case 3:
        tabBarSize = 3;
        break;
      case 5:
        tabBarSize = 2;
        break;
    }
    _tabController = TabController(length: tabBarSize, vsync: this);
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
        initialValue: (widget.serviceEvent?.dateOfFollowUpService != null)
            ? Helper.getShortDate(widget.serviceEvent?.dateOfFollowUpService)
            : "Non available",
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
    List<LeakInspection> leaksInspectionInServiceEvent =
        widget.serviceEvent.leakInspection;
    leaksInspectionInServiceEvent
        .sort((i, j) => i.leakInspectionType.compareTo(j.leakInspectionType));
    // Sort the leak inspections first
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

    // Prepare tab depending on service event type :
    // 2 = no material transfer
    // 3 = show everything
    // 5 = no leak inspection

    List<Widget> tabBars = [];
    List<Widget> tabBarViews = [];
    print("WorkItemID ${widget.serviceEvent.workItemID}");
    if (widget.serviceEvent.workItemTypeID == 2) {
      tabBars = [
        Tab(
          text: 'Information',
        ),
        Tab(
          text: 'Leak Inspection',
        )
      ];
      tabBarViews = [
        SingleChildScrollView(
            child: Column(
          children: <Widget>[...serviceEventHeader],
        )),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ...leaks
            ],
          ),
        ),
      ];
    } else if (widget.serviceEvent.workItemTypeID == 5) {
      tabBars = [
        Tab(
          text: 'Information',
        ),
        Tab(
          text: 'Gas Transfer(${widget.serviceEvent.materialTransfer.length})',
        )
      ];
      tabBarViews = [
        SingleChildScrollView(
            child: Column(
          children: <Widget>[...serviceEventHeader],
        )),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ...materialTransfers,
            ],
          ),
        ),
      ];
    } else /* if (widget.serviceEvent.workItemTypeID == 3) */ {
      tabBars = [
        Tab(
          text: 'Information',
        ),
        Tab(
          text: 'Leak Inspection',
        ),
        Tab(
          text: 'Gas Transfer(${widget.serviceEvent.materialTransfer.length})',
        )
      ];
      tabBarViews = [
        SingleChildScrollView(
            child: Column(
          children: <Widget>[...serviceEventHeader],
        )),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ...leaks
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ...materialTransfers,
            ],
          ),
        ),
      ];
    }

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
                tabs: <Widget>[...tabBars],
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[...tabBarViews],
                ),
              ))
            ],
          ),
        ));
  }
}
