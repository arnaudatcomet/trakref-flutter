import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/widget/search_widget.dart';
import 'package:trakref_app/widget/service_event_widget.dart';

class PageSearchBloc extends StatefulWidget {
  @override
  _PageSearchBlocState createState() => _PageSearchBlocState();
}

class _PageSearchBlocState extends State<PageSearchBloc> with SingleTickerProviderStateMixin {
  bool _assignedtoMe = false;
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
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
                Icon(Icons.ac_unit,
                size: 40, color: Colors.black87)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppOutlineButton(),
                  Row(
                    children: <Widget>[
                      Text('Assigned to me', style: Theme.of(context).textTheme.body1),
                      Switch(
                        value: _assignedtoMe,
                        onChanged: (bool value) {
                        _assignedtoMe = value;
                        },
                      )
                    ],
                  )

                ],
              ),
            ),
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
                  controller: _controller,
                  children: <Widget>[
                    SearchResultWidget(),
                    Center( child: Text("Page 2")),
                    Center( child: Text("Page 3"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        ServiceItemTile('#186305', 'Chateau de Chappy', 'Brandon Sotelo', 'TO DO'),
        ServiceItemTile('#6433', '#1000 COMMERCIAL TOWER', 'Brandon Sotelo', 'DONE'),
        ServiceItemTile('#528', '#528 - Supermarket', 'Brandon Sotelo', 'DONE'),
        ServiceItemTile('#263791', 'Chateau de Chappy', 'Brandon Sotelo', 'TO DO')
      ],
    );
  }
}
