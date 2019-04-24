import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/screens/search/filter/result_search_filter.dart';
import 'package:trakref_app/screens/search/service_event/result_asset.dart';
import 'package:trakref_app/screens/search/service_event/result_location.dart';
import 'package:trakref_app/screens/search/service_event/result_service_event.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';
import 'package:trakref_app/widget/search_widget.dart';
import 'package:trakref_app/widget/service_event_widget.dart';

class PageSearchBloc extends StatefulWidget {
  @override
  _PageSearchBlocState createState() => _PageSearchBlocState();
}

class _PageSearchBlocState extends State<PageSearchBloc> with SingleTickerProviderStateMixin {
  bool _assignedtoMe = false;
  TabController _controller;
  bool _isServiceEventsLoaded = false;
  bool _isCylindersLoaded = false;
  bool _isLocationsLoaded = false;

  // List of service events
  List<WorkOrder> _serviceEventsResult;
  List<Location> _locationsResult;
  List<Asset> _assetsResult;

  getServiceEvents(int locationID) {
    // Below for showing the GET Work Orders
    ApiService api = ApiService();
    var baseUrl = "https://api.trakref.com/v3.21/WorkOrders?locationID=$locationID";
    api.getResult<WorkOrder>(baseUrl).then((results) {
      _isServiceEventsLoaded = true;
      for (WorkOrder order in results) {
        print("> ${order.workOrderNumber}");
        setState(() {
          _serviceEventsResult = results;
        });
      }
    });
  }

  getLocations() {
    // Below for showing the GET Work Orders
    ApiService api = ApiService();
    var baseUrl = "https://api.trakref.com/v3.21/location";
    api.getResult<Location>(baseUrl).then((results) {
      _isLocationsLoaded = true;
      for (Location location in results) {
        print("> ${location.name} > ${location.physicalAddress1}");
        setState(() {
          _locationsResult = results;
        });
      }
    });
  }

  getCylinders(int locationID) {
    // Below for showing the GET Work Orders
    ApiService api = ApiService();
    var baseUrl = "https://api.trakref.com/v3.21/assets?locationID=$locationID";
    api.getResult<Asset>(baseUrl).then((results) {
      _isCylindersLoaded = true;
      for (Asset asset in results) {
        print("> ${asset.name} > ${asset.assetStatus}");
        setState(() {
          _assetsResult = results;
        });
      }
    });
  }

  @override
  void initState() {
    // We probably need to move that to multiple locations IDs
    int locationID = 47658;

    // Below for showing the GET Work Orders
    getServiceEvents(locationID);

    // Showing the Locations
    getLocations();

    // Showing the Assets
    getCylinders(locationID);

    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Search header
    Widget searchHeader = Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child:
          Container(
            child: Flex(direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SearchWidget(),
                  )
                ]
            ),
          ),
        ),
        // Need to replace with the camera picture
        new Container(
          child: new Image.asset("assets/images/barcode-icon.png",
              height: 30,
              alignment: Alignment.centerLeft,
              fit: BoxFit.fitHeight),
          margin: new EdgeInsets.only(left:10, right: 10),
        ),
      ],
    );
    Widget filterHeader = Padding(
      padding: EdgeInsets.only(
          left: 10,
          right: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppOutlineButton(
            title: "Filter",
            onPressed: () {
              print("this is a test");
              // Show the filter options
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
                return SearchFilter(
                );
              }));
            },
          ),
          Row(
            children: <Widget>[
              Text('Assigned to me', style: Theme.of(context).textTheme.body1),
              Switch(
                value: _assignedtoMe,
                onChanged: (bool value) {
                  _assignedtoMe = value;
                },
                activeThumbImage: AssetImage("assets/images/toggle-on.png"),
                inactiveThumbImage: AssetImage("assets/images/toggle-off.png"),
              )
            ],
          )

        ],
      ),
    );

    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            searchHeader,
            SizedBox(
              height: 10,
            ),
            filterHeader,
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: AppColors.gray.withAlpha(15),
                          width: 1
                      ),
                      bottom: BorderSide(
                          color: AppColors.gray.withAlpha(15),
                          width: 1
                      )
                  )
              ),
              child: TabBar(
                labelColor: AppColors.gray,
                controller: _controller,
                indicatorColor: AppColors.gray,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold
                ),
                tabs: <Widget>[
                  Tab(
                    text: 'Service events',
                  ),
                  Tab(
                    text: 'Cylinders',
                  ),
                  Tab(
                    text: 'Locations',
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  children: <Widget>[
                    (this._isServiceEventsLoaded == false ) ? FormBuild.buildLoader() : ServiceEventResultWidget(orders: _serviceEventsResult),
                    (this._isCylindersLoaded == false) ? FormBuild.buildLoader() : AssetResultWidget(assets: _assetsResult),
                    (this._isLocationsLoaded == false ) ? FormBuild.buildLoader() : LocationResultWidget(locations: _locationsResult)
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}