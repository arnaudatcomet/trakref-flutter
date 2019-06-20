import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/models/search_filter_options.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/repository/preferences_service.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/screens/details/page_cylinder_detail_bloc.dart';
import 'package:trakref_app/screens/details/page_location_detail_bloc.dart';
import 'package:trakref_app/screens/details/page_work_order_detail_bloc.dart';
import 'package:trakref_app/screens/search/filter/result_search_filter.dart';
import 'package:trakref_app/screens/search/service_event/result_asset.dart';
import 'package:trakref_app/screens/search/service_event/result_location.dart';
import 'package:trakref_app/screens/search/service_event/result_service_event.dart';
import 'package:trakref_app/viewmodel/cylinder_model.dart';
import 'package:trakref_app/viewmodel/locations_model.dart';
import 'package:trakref_app/viewmodel/workorders_model.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/search_widget.dart';

enum PageSearchTab { ServiceEvents, Cylinders, Locations }

class PageSearchBloc extends StatefulWidget {
  @override
  _PageSearchBlocState createState() => _PageSearchBlocState();
}

class _PageSearchBlocState extends State<PageSearchBloc>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<PageSearchBloc> {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  TextEditingController _textController = TextEditingController();

//  ApiService api = ApiService();
  TrakrefAPIService api = TrakrefAPIService();

  @override
  void dispose() {
    api.close();
    _textController.dispose();
    super.dispose();
  }

  void onTabControllerIndexChanged() {
    int indexChanged = _tabController.index;
    print("onTabControllerIndexChanged $indexChanged");
  }

  @override
  void initState() {
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
          child: Container(
            child: Flex(direction: Axis.vertical, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: SearchWidget(
                  controller: _textController,
                ),
              )
            ]),
          ),
        ),
        // Need to replace with the camera picture
        new Container(
          child: new Image.asset("assets/images/barcode-icon.png",
              height: 30,
              alignment: Alignment.centerLeft,
              fit: BoxFit.fitHeight),
          margin: new EdgeInsets.only(left: 10, right: 10),
        ),
      ],
    );
    Widget filterHeader = Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppOutlineButton(
            title: "Filter",
            onPressed: () {
              // Show the filter options
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return SearchFilter(
                  delegate: (listOptions) {
                    FilterPreferenceService().resetAll();
                    bool showAroundMe = false;
                    for (SearchFilterOptions option in listOptions) {
                      FilterPreferenceService().setFilter(option, true);
                      // If assigned to me then change the switch 'Assigned to me' state
                      if (option == SearchFilterOptions.AroundMe) {
                        showAroundMe = true;
                      }
                    }

                    if (showAroundMe) {
                      BaseView<LocationsModel>(
                        onModelReady: (model) => model.fetchLocationsAroundMe(),
                      );
                    } else {
                      BaseView<LocationsModel>(
                        onModelReady: (model) => model.fetchLocations(),
                      );
                    }

                    print("listOptions $listOptions");
                  },
                );
              }));
            },
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
                            color: AppColors.gray.withAlpha(15), width: 1),
                        bottom: BorderSide(
                            color: AppColors.gray.withAlpha(15), width: 1))),
                child: TabBar(
                  labelColor: AppColors.gray,
                  controller: _tabController,
                  indicatorColor: AppColors.gray,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                      BaseView<WorkOrdersModel>(onModelReady: (model) {
                        model.fetchWorkOrders();
                        model.controller = _textController;
                        model.controller.addListener(() => setState(() {}));
                      }, builder: (context, model, child) {
                        List<WorkOrder> orders = model.orders;
                        if (_textController.text.isEmpty == false &&
                            (_tabController.index ==
                                PageSearchTab.ServiceEvents.index)) {
                          orders = model.fetchFromSearch(_textController.text);
                        }

                        return (model.state == ViewState.Busy)
                            ? FormBuild.buildLoader()
                            : RefreshIndicator(
                                color: AppColors.blueTurquoise,
                                child: ServiceEventResultWidget(
                                  orders: orders,
                                  serviceEventSelectedHandle: (order) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builderContext) {
                                      return PageWorkOrderDetailBloc(
                                          order: order);
                                    }));
                                  },
                                ),
                                onRefresh: () {
                                  model.fetchWorkOrders();
                                },
                              );
                      }),
                      BaseView<CylindersModel>(
                          onModelReady: (model) => model.fetchCylinders(),
                          builder: (context, model, child) {
                            List<Asset> cylinders = model.assets;
                            if (_textController.text.isEmpty == false &&
                                (_tabController.index ==
                                    PageSearchTab.Cylinders.index)) {
                              cylinders =
                                  model.fetchFromSearch(_textController.text);
                            }
                            return (model.state == ViewState.Busy)
                                ? FormBuild.buildLoader()
                                : RefreshIndicator(
                                    color: AppColors.blueTurquoise,
                                    child: AssetResultWidget(
                                      assets: cylinders,
                                      assetSelectedHandle: (assetSelected) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builderContext) {
                                          return PageCylinderDetailBloc(
                                              asset: assetSelected);
                                        }));
                                      },
                                    ),
                                    onRefresh: () {
                                      _textController.clear();
                                      model.fetchCylinders();
                                    },
                                  );
                          }),
                      BaseView<LocationsModel>(onModelReady: (model) {
                        // Start the geolocation service, will request permission
                        model.startGeolocation();

                        // Grab all locations, independantly from current location for now
                        model.fetchLocations();
                      }, builder: (context, model, child) {
                        List<Location> locations = model.locations;
                        if (_textController.text.isEmpty == false &&
                            (_tabController.index ==
                                PageSearchTab.Locations.index)) {
                          locations = model
                              .fetchLocationsFromSearch(_textController.text);
                        }

                        if (model.state == ViewState.Busy) {
                          return FormBuild.buildLoader();
                        } else if (model.state == ViewState.Idle) {
                          return RefreshIndicator(
                            color: AppColors.blueTurquoise,
                            child: LocationResultWidget(
                              locations: locations,
                              aroundMeActionHandle: () {
                                print("aroundMeActionHandle");
                                FilterPreferenceService().setFilter(
                                    SearchFilterOptions.AroundMe, true);
                                model.fetchLocationsAroundMe();
                              },
                              locationSelectedHandle: (selectedLocation) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builderContext) {
                                  return PageLocationDetailBloc(
                                    location: selectedLocation,
                                  );
                                }));
                              },
                            ),
                            onRefresh: () {
                              _textController.clear();
                              model.fetchLocations();
                            },
                          );
                        } else if (model.state == ViewState.Error) {
                          return RefreshIndicator(
                            color: AppColors.blueTurquoise,
                            child: ListView(children: <Widget>[
                              Text("An error happened. Please try again",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold))
                            ]),
                            onRefresh: () {
                              _textController.clear();
                              model.fetchLocations();
                            },
                          );
                        }
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
