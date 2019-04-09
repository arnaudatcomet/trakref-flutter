import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

class PageTestLinkBloc extends StatefulWidget {
  @override
  _PageTestLinkBlocState createState() => _PageTestLinkBlocState();
}

class _PageTestLinkBlocState extends State<PageTestLinkBloc> {

  void getWorkOrders(int locationID) {
    // Below test for showing the GET Work Orders
    ApiService api = ApiService();
    var baseUrl = "https://api.trakref.com/v3.21/WorkOrders?locationID=$locationID";
//    var baseUrl = "https://api.trakref.com/v3.21/WorkOrders?locationID=10723";

    api.getResult<WorkOrder>(baseUrl).then((results) {
      print("api.getResult[${results.length}]");
      int i = 0;
      for (WorkOrder order in results) {
        print("#$i order is ${order.workOrderNumber} for ${order.instance}");
        i++;
      }
    });
  }

  // For now just a leak inspection
  void postRandomWorkOrder() {
    String timeNow = DateFormat(kShortReadableDateFormat).format(DateTime.now());
    String serviceTime = DateFormat(kShortDateFormat).format(DateTime.now().subtract(
      Duration(
        hours: 24
      )
    ));

    WorkOrder workOrder = WorkOrder(
      id: 1071647,
      workOrderNumber: "790345789",
      instanceID: 248,
      locationID: 10721,
      workOrderTypeID: 2,
      workOrderStatusID: 1,
      workItem: [
        WorkItem(
          wasLeakFound: false,
          assetID: 1083692,
          workItemTypeID: 2, // It's invalid if WorkItem type != 3, 2 and 5
          serviceDate: serviceTime,
          workItemStatusID: 1,
          // Repair
          repairNotes: "This is a note for workItem from Arnaud at $timeNow",
          leakInspectionCount: 1,
          leakInspection: [
            LeakInspection(
              notes: "This is a note for leakInspection from Arnaud at $timeNow"
            )
          ]
        )
      ]
    );

    ApiService().postWorkOrder(workOrder, "https://api.trakref.com/v3.21/WorkOrders");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/accounts');
                  },
                  child: Text("Show Account", style: TextStyle(
                      color: AppColors.blueTurquoise
                  )),
                )
              ],
            ),
            Row(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/assets');
                  },
                  child: Text("Add New Asset", style: TextStyle(
                      color: AppColors.blueTurquoise
                  )),
                )
              ],
            ),
            Row(
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/leaks');
                    },
                    child: Text("Add New Service Event", style: TextStyle(
                        color: AppColors.blueTurquoise
                    )),
                  )
                ]
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    // Prepare the body for the POST request
                    postRandomWorkOrder();
                  },
                  child: Text("POST Service Event"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
