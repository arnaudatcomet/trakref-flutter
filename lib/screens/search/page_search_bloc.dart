import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/models/search_filter_options.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/repository/location_service.dart';
import 'package:trakref_app/repository/preferences_service.dart';
import 'package:trakref_app/screens/details/page_cylinder_detail_bloc.dart';
import 'package:trakref_app/screens/details/page_location_detail_bloc.dart';
import 'package:trakref_app/screens/details/page_work_order_detail_bloc.dart';
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

enum PageSearchTab {
  ServiceEvents, Cylinders, Locations
}

class PageSearchBloc extends StatefulWidget {
  @override
  _PageSearchBlocState createState() => _PageSearchBlocState();
}

class _PageSearchBlocState extends State<PageSearchBloc> with SingleTickerProviderStateMixin {
  bool _assignedtoMe = false;
  TabController _tabController;
  TextEditingController _textController = TextEditingController();
  bool _isServiceEventsLoaded = false;
  bool _isCylindersLoaded = false;
  bool _isLocationsLoaded = false;

//  ApiService api = ApiService();
  TrakrefAPIService api = TrakrefAPIService();

  // List values in the 3 tabs (Service Events, Cylinders, Locations)
  List<WorkOrder> _serviceEventsResult;
  List<WorkOrder> _filteredServiceEventsResult = [];

  List<Location> _locationsResult;
  List<Location> _filteredLocationsResult = [];

  List<Asset> _assetsResult = [];
  List<Asset> _filteredAssetsResult = [];

  @override
  void dispose() {
    api.close();
    _textController.dispose();
    super.dispose();
  }

  void onSearchTextChanged() {
    // Listening to search
    String searchedText = _textController.text.toLowerCase();
    print("onSearchTextChanged > $searchedText");
    int indexChanged = _tabController.index;

    if (searchedText.isNotEmpty) {
      if (indexChanged == PageSearchTab.ServiceEvents.index) {
        _filteredServiceEventsResult.clear();
        _serviceEventsResult.forEach((workOrder) {
          if (workOrder.workOrderNumber.toLowerCase().contains(searchedText) ||
              workOrder.location.toLowerCase().contains(searchedText) ||
              workOrder.instance.toLowerCase().contains(searchedText)) {
            _filteredServiceEventsResult.add(workOrder);
          }
        });
      }
      else if (indexChanged == PageSearchTab.Cylinders.index) {
        _filteredAssetsResult.clear();
        _assetsResult.forEach((asset) {
          String serialNumber = asset.serialNumber ?? "";
          String name = asset.name ?? "";
          String assetCategory = asset.assetCategory ?? "";
          if (serialNumber.toLowerCase().contains(searchedText) ||
              name.toLowerCase().contains(searchedText) ||
              assetCategory.toLowerCase().contains(searchedText)) {
            _filteredAssetsResult.add(asset);
          }
        });
      }
      else if (indexChanged == PageSearchTab.Locations.index) {
        _filteredLocationsResult.clear();
        _locationsResult.forEach((location) {

          String physicalAddress1 = location.physicalAddress1 ?? "";
          String physicalCity = location.physicalCity ?? "";
          String name = location.name ?? "";
          String physicalState = location.physicalState ?? "";

          if (physicalAddress1.toLowerCase().contains(searchedText) ||
              physicalCity.toLowerCase().contains(searchedText) ||
              name.toLowerCase().contains(searchedText) ||
              physicalState.toLowerCase().contains(searchedText)) {
            _filteredLocationsResult.add(location);
          }
        });
      }
      setState(() {});
    }
  }

  void onTabControllerIndexChanged() {
    int indexChanged = _tabController.index;
    print("onTabControllerIndexChanged $indexChanged");
  }

  @override
  void initState() {
    // Listen to search changes
    _textController.addListener(onSearchTextChanged);

    // Grab default value for the assigned to me
     FilterPreferenceService().getValues(SearchFilterOptions.AssignedToMe).then((assignedToMe){
      setState(() {
        _assignedtoMe = assignedToMe;
      });
    });

    // Instantiate the current location
    GeolocationService().initPlatformState();

    // We probably need to move that to multiple locations IDs
    int locationID = 47658;

    // Below for showing the GET Work Orders
//    getServiceEvents(locationID);
//    getAllServiceEvents();
    api.getServiceEvents([]).then((results) {
      _isServiceEventsLoaded = true;
      setState(() {
        _serviceEventsResult = results;
      });
    }).catchError((error){
      _isServiceEventsLoaded = true;
      print("TrakrefAPIService catch error on 'getServiceEvents'");
    });

    // Showing the Locations
    api.getLocations().then((results){
      _isLocationsLoaded = true;
      setState(() {
        _locationsResult = results;
      });
    }).catchError((error){
      _isLocationsLoaded = true;
      print("TrakrefAPIService catch error on 'getLocations'");
    });

    // Showing the Assets
    api.getCylinders([]).then((results){
      _isCylindersLoaded = true;
      setState(() {
        _assetsResult = results;
      });
    }).catchError((error){
      _isCylindersLoaded = true;
      print("TrakrefAPIService catch error on 'getCylinder'");
    });

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(onTabControllerIndexChanged);

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
                    child: SearchWidget(
                      controller: _textController,
                    ),
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
              // Show the filter options
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
                return SearchFilter(
                  delegate: (listOptions) {
                    FilterPreferenceService().resetAll();
                    bool showAroundMe = false;
                    for (SearchFilterOptions option in listOptions) {
                      FilterPreferenceService().setFilter(option, true);
                      // If assigned to me then change the switch 'Assigned to me' state
                      if (option == SearchFilterOptions.AssignedToMe) {
                        print("_assignedToMe $_assignedtoMe");
                      }

                      if (option == SearchFilterOptions.AroundMe) {
                        showAroundMe = true;
                      }
                    }

                    if (showAroundMe) {
                      double currentLatitude = GeolocationService().currentLocation.latitude;
                      double currentLongitude = GeolocationService().currentLocation.longitude;
                      api.getLocationAroundMe(currentLatitude, currentLongitude, 100).then((locationResults) {
                        setState(() {
                          _locationsResult = locationResults;
                        });
                      });
                    }
                    else {
                      api.getLocations().then((locationResults){
                        setState(() {
                          _locationsResult = locationResults;
                        });
                      });
                    }

                    setState(() {
                      _assignedtoMe = (listOptions.contains(SearchFilterOptions.AssignedToMe));
                    });

                    print("listOptions $listOptions");
                  },
                );
              }));
            },
          ),
          Row(
            children: <Widget>[
              Text('Assigned to me', style: Theme.of(context).textTheme.body1),
              Switch(
                activeColor: AppColors.blueTurquoise,
                value: _assignedtoMe,
                onChanged: (bool value) {
                  _assignedtoMe = value;
                  FilterPreferenceService().setFilter(SearchFilterOptions.AssignedToMe, _assignedtoMe);
                },
              )
            ],
          )

        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                controller: _tabController,
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
                  controller: _tabController,
                  children: <Widget>[
                    (this._isServiceEventsLoaded == false ) ? FormBuild.buildLoader() : ServiceEventResultWidget(
                        orders: (_textController.text.isEmpty) ? _serviceEventsResult : _filteredServiceEventsResult,
                        serviceEventSelectedHandle: (order) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (builderContext){
                            return PageWorkOrderDetailBloc(
                              order: order
                            );
                          }));
                        }
                    ),
                    (this._isCylindersLoaded == false) ? FormBuild.buildLoader() : AssetResultWidget(
                        assets: (_textController.text.isEmpty) ? _assetsResult : _filteredAssetsResult,
                      assetSelectedHandle: (assetSelected){
                        Navigator.of(context).push(MaterialPageRoute(builder: (builderContext){
                          return PageCylinderDetailBloc(
                            asset: assetSelected,
                          );
                        }));
                      },
                    ),
                    (this._isLocationsLoaded == false ) ? FormBuild.buildLoader() : LocationResultWidget(
                      locations: (_textController.text.isEmpty) ? _locationsResult : _filteredLocationsResult,
                      aroundMeActionHandle: () {
                        print("aroundMeActionHandle");
                        FilterPreferenceService().setFilter(SearchFilterOptions.AroundMe, true);
                        double currentLatitude = GeolocationService().currentLocation.latitude;
                        double currentLongitude = GeolocationService().currentLocation.longitude;
                        TrakrefAPIService().getLocationAroundMe(currentLatitude, currentLongitude, 100).then((locationResults) {
                          setState(() {
                            _locationsResult = locationResults;
                          });
                        });
                      },
                      locationSelectedHandle: (selectedLocation) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (builderContext){
                          return PageLocationDetailBloc(
                            location: selectedLocation,
                          );
                        }));
                      },
                    )
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