import 'package:flutter/material.dart';
import 'package:trakref_app/models/location.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';


class LocationResultWidget extends StatelessWidget {
  final List<Location> locations;
  LocationResultWidget({this.locations});

  @override
  Widget build(BuildContext context) {
    return (locations == null) ? Container() : ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          Location loc = locations[index];

          return HomeCellWidget(
              line1: '',
              line2: '${loc.name}',
              line3: '${loc.physicalAddress1}',
              line4: '${loc.physicalCity}, ${loc.physicalState}',
              cellType: HomeCellType.Normal
          );
        }
    );
  }
}
