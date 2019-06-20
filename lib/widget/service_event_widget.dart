import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

// Widget for service item
class ServiceItemTile extends ListTile {
  final String line1;
  final String line2;
  final String line3;
  final String line4;

  final String status = '';

  ServiceItemTile(this.line1, this.line2, this.line3, this.line4);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 150.0,
      padding: new EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
          border: new Border(
              bottom: new BorderSide(
                  color: AppColors.lightGray,
                  width: 0.3
              )
          )
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(
            top: 6,
          )
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                line1,
                style: Theme.of(context).textTheme.display1,
              ),
              new Expanded(
                  child: new Container()
              ),
              new Container(
                width: 36,
                height: 15,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.lightGreen
                  // UIColor(red:0.55, green:0.86, blue:0.33, alpha:1)
                ),
                child: Center(
                  child: Text(
                    'TO DO',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontFamily: "SF Pro Text Regular"
                    ),
                  ),
                ),
              )
            ],
          ),
          new Padding(padding: new EdgeInsets.only(
            top: 6,
          )
          ),
          new Row(
            children: <Widget>[
              new Text(
                line2,
                style: Theme.of(context).textTheme.display2,
              )
            ],
          ),
          new Padding(padding: new EdgeInsets.only(
            top: 6,
          )
          ),
          new Row(
            children: <Widget>[
              new Text(
                line3,
                style: Theme.of(context).textTheme.display3,
              )
            ],
          ),
          new Padding(padding: new EdgeInsets.only(
            top: 6,
          )
          ),
          new Row(
            children: <Widget>[
              new Text(
                line4,
                style: Theme.of(context).textTheme.display4,
              )
            ],
          ),
        ],
      ),
    );
  }
}
