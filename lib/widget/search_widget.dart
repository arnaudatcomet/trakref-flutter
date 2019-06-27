import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

typedef SearchWidgetDelegate = void Function(String);

class SearchWidget extends StatefulWidget {
  final TextEditingController controller;
  SearchWidget({@required this.controller});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
                color: AppColors.lightGray,
                icon: Icon((widget.controller.text.isEmpty == true) ? Icons.search : Icons.close),
                onPressed: () {
                  print("show something : ${widget.controller.text}");
                  if (widget.controller.text.isEmpty == false) {
                    widget.controller.text = "";
                  }
                  setState(() {
                    
                  });
                },
            ),
            contentPadding: EdgeInsets.only(left: 15, top: 13),
            hintText: 'Search by Event, Cylinders or Locations',
            hintStyle: TextStyle(
                color: AppColors.lightGray,
                fontSize: 14,
                fontFamily: 'Quicksand'
            )
        ),
      ),
    );
  }
}