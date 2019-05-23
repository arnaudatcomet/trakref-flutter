import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/dropdown.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/screens/adding/service_event/page_service_event_add_bloc.dart';
import 'package:trakref_app/screens/adding/work_order/page_select_work_order_bloc.dart';
import 'package:trakref_app/screens/adding/cylinder/page_asset_add_block.dart';


class PageAddingBloc extends StatefulWidget {
  @override
  _PageAddingBloc createState() => _PageAddingBloc();
}

class _PageAddingBloc extends State<PageAddingBloc> {
  bool _isLoadedWorkOrder = false;
  WorkOrder _currentWorkOrder;
  List<Asset> assetsResult;

  @override
  void initState() {
    print("PageAddingBloc > _currentWorkOrder is ? ");
    TrakrefAPIService().getCurrentWorkOrder().then((workOrder){
      print("PageAddingBloc > _currentWorkOrder is $workOrder");
      if (mounted) {
        _currentWorkOrder = workOrder;
        _isLoadedWorkOrder = true;
        setState(() {

        });
      }
    }).catchError((error){
      print("PageAddingBloc > _currentWorkOrder has an error");
      if (mounted) {
        _isLoadedWorkOrder = true;
        setState(() {
        });
      }
    });
    super.initState();
  }

  Widget buildItem(String title, bool isPushing, Function onTapped) {
    return GestureDetector(
        onTap: onTapped,
        child: Row(
          children: <Widget>[
            SizedBox(height: 50),
            Text(title,
                style: Theme.of(context).textTheme.headline.copyWith(
                    color: (isPushing) ? Colors.black : Colors.black38
                )
            ),
            Spacer(),
            (isPushing) ? Icon(Icons.chevron_right) : Container()
          ],
        )
    );
  }

  Widget buildThreeLinesItem(String firstLine, String secondLine, String thirdLine, bool isPushing, Function onTapped) {
    return GestureDetector(
        onTap: onTapped,
        child: Row(
          children: <Widget>[
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(firstLine,
                    style: Theme.of(context).textTheme.headline.copyWith(
                        color: (isPushing) ? Colors.black : Colors.black38
                    )
                ),
                Text(secondLine,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: (isPushing) ? Colors.black : Colors.black38
                    )
                ),
                Text(thirdLine,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: (isPushing) ? AppColors.blueTurquoise : Colors.black38
                    )
                )
              ],
            ),
            Spacer(),
            (isPushing) ? Icon(Icons.chevron_right) : Container()
          ],
        )
    );
  }

  void pushSelectWorkOrder(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
      return PageSelectCurrentWorkOrderBloc(
        delegate: (WorkOrder selected) {
          print("PageSelectCurrentWorkOrderBloc selected $selected");
          TrakrefAPIService().setWorkOrder(selected);
          _currentWorkOrder = selected;
          setState(() {
          });
        },
      );
    }));
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> rows;
    print("_currentWorkOrder $_currentWorkOrder");
    if (_currentWorkOrder == null) {
      rows = [
        buildItem("Select Work Order",true, () {
          pushSelectWorkOrder(context);
        }),
        Divider(),
        buildItem("Cylinder",true, () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return PageAssetAddBloc();
          }));
        }),
        Divider(),
        buildItem("Appliance",false, null),
        Divider(),
        buildItem("Service Event", false, null)];
    }
    else {
      rows = [
        buildThreeLinesItem("${_currentWorkOrder.workOrderNumber}", "at ${_currentWorkOrder.location}", "Change Work Order",true, (){
          pushSelectWorkOrder(context);
        }),
        Divider(),
        buildItem("Cylinder",true, () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return PageAssetAddBloc();
          }));
        }),
        Divider(),
        buildItem("Appliance",false, null),
        Divider(),
        buildItem("Service Event", true, () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
            return PageServiceEventAddBloc(
              currentWorkOrder: _currentWorkOrder
            );
          }));
        })
      ];
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Add new",
                      style: Theme
                          .of(context)
                          .textTheme
                          .title,
                      textAlign: TextAlign.start,
                    )
                  ],
                )
                ,
                SizedBox(height: 20),
                ...rows,
                Divider(),
              ],
            ),
          )),
    );
  }
}
