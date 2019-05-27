import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';
import 'package:trakref_app/repository/location_service.dart';

class LocationCellResultWidget extends StatefulWidget {
  final double locationLatitude;
  final double locationLongitude;
  final String locationName;
  final String physicalAddress1;
  final String physicalCity;
  final String physicalState;

  double distance;

  LocationCellResultWidget({this.locationLatitude, this.locationLongitude,
    this.locationName, this.physicalAddress1, this.physicalCity,
    this.physicalState});

  @override
  _LocationCellResultWidgetState createState() => _LocationCellResultWidgetState();
}

class _LocationCellResultWidgetState extends State<LocationCellResultWidget> {
  @override
  void initState() {
    GeolocationService().calculateDistance(widget.locationLatitude, widget.locationLongitude).then((distance) {
//      print("calculateDistance = $distance meters");
      setState((){
        widget.distance = distance;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Fix to avoid a line with only ','
    List<String> lastLine = [
      widget.physicalCity,
      widget.physicalState
    ];
    lastLine.removeWhere((i) => i==null);

    Widget locationCell = HomeCellWidget(
        line1: (widget.distance == null) ? "" : '${widget.distance.toStringAsFixed(0)} meters',
        line2: '${widget.locationName}',
        line3: '${widget.physicalAddress1 ?? ""}',
        line4: lastLine.join(","),
        cellType: HomeCellType.Normal
    );
    return locationCell;
  }
}

class LocationResultWidget extends StatefulWidget {
  final List<Location> locations;
  Function aroundMeActionHandle;
  Function locationSelectedHandle;
  LocationResultWidget({this.locations, this.aroundMeActionHandle, this.locationSelectedHandle});

  @override
  _LocationResultWidgetState createState() => _LocationResultWidgetState();
}

class _LocationResultWidgetState extends State<LocationResultWidget> {
  @override
  Widget build(BuildContext context) {
    // List of locations
    ListView locationsWidget = ListView.builder(
        itemCount: (widget.locations?.length ?? 0) + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                widget.aroundMeActionHandle();
              },
              child: LocationHeaderTile()
            );
          }
          Location loc = widget.locations[index-1];
          return GestureDetector(
            onTap: () {
              widget.locationSelectedHandle(loc);
            },
            child: LocationCellResultWidget(locationLatitude: loc.lat,
              locationLongitude: loc.long,
              locationName: loc.name,
              physicalAddress1: loc.physicalAddress1,
              physicalCity: loc.physicalCity,
              physicalState: loc.physicalState,
            ),
          );
        }
    );

    // Need to create a header to allow geolocation and list of locations

    return (widget.locations == null) ? Container() : locationsWidget;
  }
}

class LocationHeaderTile extends ListTile {
  @override
  Widget build(BuildContext context) {
    Widget header = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 40),
        Icon(Icons.pin_drop, color: AppColors.blueTurquoise),
        SizedBox(width: 20),
        Text("AROUND ME", style: Theme.of(context).textTheme.display1.copyWith(
          fontWeight: FontWeight.bold
        )
        )
      ],
    );

    return header;
  }
}
