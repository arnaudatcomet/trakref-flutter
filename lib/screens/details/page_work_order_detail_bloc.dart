import 'package:flutter/material.dart';
import 'package:trakref_app/constants.dart';
import 'package:trakref_app/main.dart';
import 'package:intl/intl.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

//PageCylinderDetailBloc
class PageWorkOrderDetailBloc extends StatefulWidget {
  WorkOrder order;

  PageWorkOrderDetailBloc({this.order});

  @override
  _PageWorkOrderDetailBlocState createState() => _PageWorkOrderDetailBlocState();
}

class _PageWorkOrderDetailBlocState extends State<PageWorkOrderDetailBloc> {

  @override
  void initState() {
    print("_PageServiceEventDetailBlocState > initState");
    print("_PageServiceEventDetailBlocState workItemCount > ${widget.order.workItemCount}");
    for (WorkItem item in widget.order.workItem) {
      print("service event #${item.materialType}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.order.workOrderNumber.toUpperCase(), style: Theme
                  .of(context)
                  .textTheme
                  .display2,
              ),
              SizedBox(
                width: 12,
              ),
              Chip(
                backgroundColor: AppColors.blueTurquoise,
                label: Text(widget.order.workOrderStatus,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              )
            ],
          ),
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
            child: Column(
              children: <Widget>[
                WorkOrderList(
                  order: widget.order,
                )
              ],
            )
        )
    );
  }
}

class WorkOrderList extends StatelessWidget {
  WorkOrder order;
  WorkOrderList({this.order});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        color: Colors.white,
        child: new ListView.builder(
//          itemExtent: 160.0,
          itemCount: order.workItem.length + 1,
          itemBuilder: (_, index) {
            if (index == 0) {
              return
                SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        children: <Widget>[
                          FormBuild.buildTextfieldRow(
                              "LocationKey", "Location",
                              order.location),
                          FormBuild.buildTextfieldRow(
                              "WorkOrderTypeKey", "Work Order Type",
                              order.workOrderType),
                          FormBuild.buildTextfieldRow(
                              "StatusReasonKey", "Status Reason",
                              order.workOrderStatusReason),
                          FormBuild.buildTextfieldRow(
                              "RequestDetailsKey", "Request Details",
                              order.requestDetails),

                        ]
                    )
                );
            }
            return ServiceEventRow(
              serviceEvent: order.workItem[index - 1],
            );
          },
        ),
      ),
    );
  }
}

class ServiceEventRow extends StatelessWidget {
  WorkItem serviceEvent;

  ServiceEventRow({this.serviceEvent});

  Widget buildCircleAvatar(String type, double gasAdded, double gasRemoved) {
    return CircleAvatar(
      radius: 44,
      backgroundColor: AppColors.blueTurquoise,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(type.toUpperCase(), style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.file_download,
                size: 12,
                color: Colors.white,
              ),
              Text("${gasAdded.truncate().toString()} lbs", style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.file_upload,
                size: 12,
                color: Colors.white,
              ),
              Text("${gasRemoved.truncate().toString()} lbs", style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
              ))
            ],
          )
        ],
      ),
    );
  }

  String shortDate(String serviceEventDate) {
    DateTime serviceDate = DateFormat(kShortTimeDateFormat).parse(serviceEvent.serviceDate);
    return DateFormat(kShortDateFormat)
        .format(serviceDate);
  }

  @override
  Widget build(BuildContext context) {
    final serviceEventThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 8.0),
      child: new Hero(
        tag: 'service-event-${serviceEvent.workItemID}',
        child: buildCircleAvatar("LE", serviceEvent.gasLbsAdded, serviceEvent.gasLbsRemoved),
      ),
    );

    final serviceEventCard = new Container(
      margin: const EdgeInsets.only(left: 54.0, right: 8.0),
      decoration: new BoxDecoration(
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
            Text(serviceEvent.asset, style: Theme
                .of(context)
                .textTheme
                .display2),
            Text(
                serviceEvent.materialType
            ),
            Text("Reason : ${serviceEvent.serviceTransferReason ?? "None"}", style: Theme
                .of(context)
                .textTheme
                .display1),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.access_time, size: 12.0,
                    color: AppColors.gray),
                Text("${shortDate(serviceEvent.serviceDate)}", style: Theme
                    .of(context)
                    .textTheme
                    .display3),
                Container(width: 24.0),
                Icon(Icons.history, size: 14.0,
                    color: AppColors.gray),
                Text(
                    "${shortDate(serviceEvent.dateOfFollowUpService)}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .display3),
              ],
            )
          ],
        ),
      ),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        child: new Stack(
          children: <Widget>[
            serviceEventCard,
            serviceEventThumbnail,
          ],
        ),
      ),
    );
  }

  _navigateTo(context, String id) {
  }
}
