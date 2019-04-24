import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/widget/button_widget.dart';

class SearchFilter extends StatefulWidget {
  bool assignedToMe = false;
  bool aroundMe = false;
  bool opened = false;

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  bool exampleValue = true;

  @override
  Widget build(BuildContext context) {
    Widget buildSettings(String title, bool defaultValue, Function onChanged) {
      return Row(
        children: <Widget>[
          SizedBox(width: 20),
          Text(title),
          Spacer(),
          Switch(
              activeColor: AppColors.blueTurquoise,
              value: defaultValue,
              onChanged: onChanged
          ),
          SizedBox(width: 20)
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(child: Container(color: AppColors.border, height: 1), preferredSize: Size.fromHeight(1)),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close, color: AppColors.gray), onPressed: () {
          Navigator.of(context).pop();
        }
        ),
        actions: <Widget>[
          TextButton(
              title:"Erase All",
              onPressed: () {
                // Erase all actions
                print("Erase all the actions");
                setState(() {
                  widget.assignedToMe = false;
                  widget.aroundMe = false;
                  widget.opened = false;
                });
              }
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          buildSettings("Assigned to me", widget.assignedToMe, (switchValue) {
            setState(() {
              widget.assignedToMe = switchValue;
            });
            print("'Assigned to me = $switchValue'");
          }),
          buildSettings("Around me", widget.aroundMe, (switchValue) {
            setState(() {
              widget.aroundMe = switchValue;
            });
            print("'Around me = $switchValue'");
          }),
          buildSettings("Open", widget.opened, (switchValue) {
            setState(() {
              widget.opened = switchValue;
            });
            print("'Open me = $switchValue'");
          }),
          Divider(indent: 0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              TextButton(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueTurquoise,
                  title:"Show Result",
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              )
            ],
          )

        ],
      ),
    );
  }
}
