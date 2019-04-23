import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

enum HomeCellType {StickerTODO, StickerCOMPLETE, StickerCYLINDER, Normal}

class HomeCellWidget extends ListTile {
  String line1;
  String line2;
  String line3;
  String line4;

  HomeCellType cellType;

  HomeCellWidget({this.line1, this.line2, this.line3, this.line4, this.cellType});

  Color getBadgeColor(HomeCellType type) {
    switch (type) {
      case HomeCellType.Normal:
        return null;
      case HomeCellType.StickerCOMPLETE:
        return Colors.orange;
      case HomeCellType.StickerTODO:
        return AppColors.lightGreen;
    }
  }

  String getBadgeText(HomeCellType type) {
    switch (type) {
      case HomeCellType.Normal:
        return "";
      case HomeCellType.StickerCOMPLETE:
        return "COMPLETED";
      case HomeCellType.StickerTODO:
        return "TO DO";
    }
  }

  Widget buildLine(String text, TextStyle style) {
    return Row(
        children: <Widget>[
          new Text(
            text ?? "",
            style: style,
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create the badge if it's necessary
    Widget badgeWidget = Visibility(
        visible: (this.cellType == HomeCellType.StickerTODO || this.cellType == HomeCellType.StickerCOMPLETE),
        child: Container(
//          width: 36,
//          height: 15,
        padding: EdgeInsets.all(5),
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: getBadgeColor(cellType)
            // UIColor(red:0.55, green:0.86, blue:0.33, alpha:1)
          ),
          child: Center(
            child: Text(
              getBadgeText(cellType),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontFamily: "SF Pro Text Regular"
              ),
            ),
          ),
        )
    );

    return Container(
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
          Padding(padding: new EdgeInsets.only(
            top: 6,
          )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                line1,
                style: Theme.of(context).textTheme.display1,
              ),
              Spacer(),
              badgeWidget,
            ],
          ),
          buildLine(line2, Theme.of(context).textTheme.display2),
          SizedBox(height: 6),
          buildLine(line3, Theme.of(context).textTheme.display3),
          SizedBox(height: 6),
          buildLine(line4, Theme.of(context).textTheme.display4),
        ],
      ),
    );
  }
}
