import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

class PageTestLinkBloc extends StatefulWidget {
  @override
  _PageTestLinkBlocState createState() => _PageTestLinkBlocState();
}

class _PageTestLinkBlocState extends State<PageTestLinkBloc> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/accounts');
                  },
                  child: Text("Show Account", style: TextStyle(
                      color: AppColors.blueTurquoise
                  )),
                )
              ],
            ),
            Row(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/assets');
                  },
                  child: Text("Add New Asset", style: TextStyle(
                      color: AppColors.blueTurquoise
                  )),
                )
              ],
            ),
            Row(
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/leaks');
                    },
                    child: Text("Add New Service Event", style: TextStyle(
                        color: AppColors.blueTurquoise
                    )),
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}
