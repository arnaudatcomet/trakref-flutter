import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';


class LocationResultWidget extends StatelessWidget {
  final List<Location> locations;
  LocationResultWidget({this.locations});

  @override
  Widget build(BuildContext context) {
    // List of locations
    ListView locationsWidget = ListView.builder(
        itemCount: locations.length+1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return LocationHeaderTile();
          }

          Location loc = locations[index-1];

          return HomeCellWidget(
              line1: '',
              line2: '${loc.name}',
              line3: '${loc.physicalAddress1 ?? ""}',
              line4: '${loc.physicalCity ?? ""}, ${loc.physicalState ?? ""}',
              cellType: HomeCellType.Normal
          );
        }
    );

    // Need to create a header to allow geolocation and list of locations



    return (locations == null) ? Container() : locationsWidget;
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
