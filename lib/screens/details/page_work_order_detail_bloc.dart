import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trakref_app/helper.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/preferences_service.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/screens/details/page_service_event_detail_bloc.dart';
import 'package:trakref_app/viewmodel/workorders_details_model.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

//PageCylinderDetailBloc
class PageWorkOrderDetailBloc extends StatefulWidget {
  final WorkOrder order;

  PageWorkOrderDetailBloc({this.order});

  @override
  _PageWorkOrderDetailBlocState createState() =>
      _PageWorkOrderDetailBlocState();
}

class _PageWorkOrderDetailBlocState extends State<PageWorkOrderDetailBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.filter_list, color: AppColors.blueTurquoise),
          onPressed: () {},
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.gray),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white.withOpacity(0.0),
        ),
        body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.order.workOrderNumber.toUpperCase(),
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.start,
                  ),
                ),
                WorkOrderList(
                  order: widget.order,
                )
              ],
            )));
  }
}

class WorkOrderList extends StatefulWidget {
  final WorkOrder order;
  WorkOrderList({this.order});

  @override
  _WorkOrderListState createState() => _WorkOrderListState();
}

class _WorkOrderListState extends State<WorkOrderList>
    with TickerProviderStateMixin {
  Color backgroundColor;

  Widget buildChip(String title, bool active) {
    return (!active)
        ? Chip(
            shadowColor: Colors.black,
            backgroundColor: AppColors.gray,
            label: Text(title, style: TextStyle(color: Colors.white30)))
        : Chip(
            backgroundColor: AppColors.blueTurquoise,
            label: Text(title, style: TextStyle(color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<WorkOrdersDetailModel>(
      onModelReady: (model) {
        model.init(widget.order);
        backgroundColor = (model.currentWorkOrder.workItem.length == 0)
        ? Colors.white
        : AppColors.blueTurquoise;
      },
      builder: (context, model, child) {
        var workOrderBodyContainer = Flexible(
          child: Container(
            color: backgroundColor,
            child: new ListView.builder(
              itemCount: model.filteredServiceEvents.length + 1,
              itemBuilder: (_, index) {
                if (index == 0) {
                  var workOrderInfoContainer = Container(
                    color: Colors.white,
                    child: (model.isExpanded == false)
                        ? Container(color: Colors.white)
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                FormBuild.buildTextfieldRow("LocationKey",
                                    "Location", model.currentWorkOrder.location,
                                    enabled: false),
                                FormBuild.buildTextfieldRow("ClientKey",
                                    "Client", model.currentWorkOrder.instance,
                                    enabled: false),
                                FormBuild.buildTextfieldRow(
                                    "WorkOrderTypeKey",
                                    "Work Order Type",
                                    model.currentWorkOrder.workOrderType,
                                    enabled: false),
                                FormBuild.buildTextfieldRow(
                                    "StatusReasonKey",
                                    "Status Reason",
                                    model
                                        .currentWorkOrder.workOrderStatusReason,
                                    enabled: false),
                                FormBuild.buildTextfieldRow(
                                    "RequestDetailsKey",
                                    "Request Details",
                                    model.currentWorkOrder.requestDetails,
                                    enabled: false),
                                Row(
                                  children: <Widget>[
                                    FormBuild.buildTextField(
                                        key: Key("ScheduleDateKey"),
                                        initialValue: Helper.getShortDate(model
                                                .currentWorkOrder
                                                .scheduleDate) ??
                                            " ",
                                        label: "Schedule Date",
                                        enabled: false),
                                    FormBuild.buildTextField(
                                        key: Key("DueDateKey"),
                                        initialValue: Helper.getShortDate(model
                                                .currentWorkOrder.dueDate) ??
                                            " ",
                                        label: "Due Date",
                                        enabled: false),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  );
                  return SingleChildScrollView(
                      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(children: <Widget>[
                    AnimatedSize(
                      vsync: this,
                      child: workOrderInfoContainer,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    (model.currentWorkOrder.workItem.length == 0)
                        ? Container()
                        : Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.show_chart,
                                      size: 30,
                                      color: AppColors.blueTurquoise,
                                    ),
                                    Text(
                                      "Work Activity",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .copyWith(
                                              color: AppColors.blueTurquoise),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        print(
                                            "Current option is : ${model.currentOption} / ${WorkOrderActivityOptions.LeakInspection}");
                                        model.set(WorkOrderActivityOptions
                                            .LeakInspection);
                                      },
                                      child: buildChip(
                                          "Leak Inspection",
                                          model.currentOption ==
                                              WorkOrderActivityOptions
                                                  .LeakInspection),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.set(WorkOrderActivityOptions
                                            .ServiceAndLeakRepair);
                                      },
                                      child: buildChip(
                                          "Service Leak Repair",
                                          model.currentOption ==
                                              WorkOrderActivityOptions
                                                  .ServiceAndLeakRepair),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        model.set(
                                            WorkOrderActivityOptions.Shutdown);
                                        model.toggleExpand();
                                      },
                                      child: buildChip(
                                          "Shutdown",
                                          model.currentOption ==
                                              WorkOrderActivityOptions
                                                  .Shutdown),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 30,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                )
                              ],
                            ),
                          )
                  ]));
                }
                return ServiceEventRow(
                  backgroundColor: backgroundColor,
                  serviceEvent: model.filteredServiceEvents[index - 1],
                );
              },
            ),
          ),
        );
        return workOrderBodyContainer;
      },
    );
  }
}

class ServiceEventRow extends StatelessWidget {
  WorkItem serviceEvent;
  final backgroundColor;
  ServiceEventRow({this.serviceEvent, this.backgroundColor});

  Widget buildCircleAvatar(
      int serviceEventTypeID, double gasAdded, double gasRemoved) {
    String shortcutEventType = getServiceEventShortcutType(serviceEventTypeID);
    return CircleAvatar(
      radius: 44,
      backgroundColor: AppColors.blueTurquoise,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(shortcutEventType,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.file_download,
                size: 12,
                color: Colors.white,
              ),
              Text("${gasAdded.truncate().toString()} lbs",
                  style: TextStyle(color: Colors.white, fontSize: 12))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.file_upload,
                size: 12,
                color: Colors.white,
              ),
              Text("${gasRemoved.truncate().toString()} lbs",
                  style: TextStyle(color: Colors.white, fontSize: 12))
            ],
          )
        ],
      ),
    );
  }

  String getServiceEventShortcutType(int serviceType) {
    print("Get service type $serviceType");
    if (serviceType == 1) {
      return "SI";
    }
    if (serviceType == 2) {
      return "LE";
    }
    if (serviceType == 3) {
      return "SLR";
    }
    if (serviceType == 5) {
      return "SH";
    }
    return "";
  }

  Widget buildTextField({String initialValue, String label}) {
    return TextFormField(
      enabled: false,
      initialValue: "${initialValue ?? ""}",
      decoration: InputDecoration(
          labelStyle: TextStyle(
              color: AppColors.blueTurquoise, fontWeight: FontWeight.bold),
          labelText: "${label ?? ""}",
          border: InputBorder.none),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceEventThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 8.0),
      child: new Hero(
        tag: 'service-event-${serviceEvent.workItemID}',
        child: buildCircleAvatar(serviceEvent.workItemTypeID,
            serviceEvent.gasLbsAdded, serviceEvent.gasLbsRemoved),
      ),
    );

    // All the styles for the form
    TextStyle bodyTextStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);

    return GestureDetector(
        onTap: () {
          print("GestureDetector > onTap()");
          Navigator.of(context).push(MaterialPageRoute(builder: (buildContext) {
            return PageServiceEventDetailBloc(
              serviceEvent: serviceEvent,
              delegate: () {
                return buildCircleAvatar(serviceEvent.workItemTypeID,
                    serviceEvent.gasLbsAdded, serviceEvent.gasLbsRemoved);
//              return serviceEventCard;
              },
            );
          }));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          color: backgroundColor,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${serviceEvent.workItemType}",
                    textAlign: TextAlign.center,
                    style: bodyTextStyle,
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: "${serviceEvent.asset}",
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: AppColors.blueTurquoise,
                            fontWeight: FontWeight.bold),
                        labelText: "System / Asset",
                        border: InputBorder.none),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: buildTextField(
                              initialValue:
                                  "${Helper.getShortDate(serviceEvent.serviceDate) ?? "Non available"}",
                              label: "Service Date"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: buildTextField(
                              initialValue: "${serviceEvent.workItemStatus}",
                              label: "Status"),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: buildTextField(
                              initialValue:
                                  "${serviceEvent.netGasLbsAdded} lbs.",
                              label: "Net Gas Added"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: buildTextField(
                              initialValue: "${serviceEvent.materialType}",
                              label: "Material Type"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
