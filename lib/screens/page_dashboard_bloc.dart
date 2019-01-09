import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/service_event_widget.dart';

// Temporary models
abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);
}

class ServiceEventItem implements ListItem {
  final String line1;
  final String line2;
  final String line3;
  final String line4;

  final String status;

  ServiceEventItem(this.line1, this.line2, this.line3, this.line4, this.status);
}

class PageDashboardBloc extends StatefulWidget {
  @override
  _PageDashboardBlocState createState() => _PageDashboardBlocState();
}

class _PageDashboardBlocState extends State<PageDashboardBloc> {
  // Properties
  final List<ListItem> items = [
    HeadingItem('Assigned to you'),
    ServiceEventItem('#186305', 'Chateau de Chappy', 'RACK', 'Brandon Sotelo', 'TO DO'),
    ServiceEventItem('#6433', '#1000 COMMERCIAL TOWER', 'RACK', 'Brandon Sotelo', 'DONE'),
    ServiceEventItem('#528', '#528 - Supermarket', 'RACK', 'Brandon Sotelo', 'DONE'),
    HeadingItem('To Synchronize'),
    ServiceEventItem('#263791', 'Chateau de Chappy', 'RACK', 'Brandon Sotelo', 'TO DO')
  ];

  // Item builder
  ListTile makeTile(ListItem item) {
    if (item is ServiceEventItem) {
      print('message ${item.line1} / ${item.line2} / ${item.line3} / ${item.line4}');
      return makeServiceEventTile(item);
    }
    else if (item is HeadingItem) {
      print('heading ${item.heading}');
      return makeHeaderTile(item);
    }
    return makeServiceEventTile(item);
  }

  ListTile makeHeaderTile(HeadingItem item) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    title: Text(
      item.heading,
      style: Theme.of(context).textTheme.title,
    ),
    trailing: const Icon(Icons.refresh)
  );

  ListTile makeServiceEventTile(ServiceEventItem item) => ListTile(
    title: Text(
      item.line1,
      style: Theme.of(context).textTheme.display1,
    ),
    subtitle: Text(
      item.line2,
      style: Theme.of(context).textTheme.display2,
    ),
  );

  // Renderer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            if (item is HeadingItem) {
              return new Container(
                decoration: BoxDecoration(
                  border: new Border(
                    bottom: new BorderSide(
                      color: AppColors.lightGray,
                      width: 0.3
                    )
                  )
                ),
                child: this.makeHeaderTile(item),
              );
            }
            else if (item is ServiceEventItem) {
              return ServiceItemTile(item.line1, item.line2, item.line3, item.line4);
            }
          }
      )
    );
  }
}
