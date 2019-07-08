import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/preferences_service.dart';
import 'package:trakref_app/widget/button_widget.dart';
import 'package:trakref_app/models/search_filter_options.dart';

typedef SearchFilterDelegate = void Function(List<SearchFilterOptions> options);

class SearchFilter extends StatefulWidget {
  SearchFilterDelegate delegate;

  SearchFilter({@required this.delegate});

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  bool aroundMeFilterValue = false;
  bool openedFilterValue = false;
  FilterPreferenceService prefs =  FilterPreferenceService();

  @override
  void initState() {
    prefs.getValues(SearchFilterOptions.AroundMe).then((aroundMeValue){
      setState(() {
        print("SearchFilterOptions.AroundMe $aroundMeValue");
        aroundMeFilterValue = aroundMeValue;
      });
    });

    prefs.getValues(SearchFilterOptions.Opened).then((openedValue){
      setState(() {
        print("SearchFilterOptions.Opened $openedValue");
        openedFilterValue = openedValue;
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSettings(String title, bool defaultValue, Function onChanged) {
      bool switchDefaultValue = false;
      if (defaultValue != null) {
        switchDefaultValue = defaultValue;
      }
      return Row(
        children: <Widget>[
          SizedBox(width: 20),
          Text(title),
          Spacer(),
          Switch(
              activeColor: AppColors.blueTurquoise,
              value: switchDefaultValue,
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
                  aroundMeFilterValue = false;
                  openedFilterValue = false;
                });
              }
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          buildSettings("Around me", aroundMeFilterValue, (switchValue) {
            setState(() {
              aroundMeFilterValue = switchValue;
            });
          }),
          buildSettings("Show Only Opened", openedFilterValue, (switchValue) {
            setState(() {
              openedFilterValue = switchValue;
            });
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
                    // Prepare the options of the filter
                    List<SearchFilterOptions> options = [];
                    if (aroundMeFilterValue != null && aroundMeFilterValue == true) {
                      options.add(SearchFilterOptions.AroundMe);
                    }
                    if (openedFilterValue!= null && openedFilterValue == true) {
                      options.add(SearchFilterOptions.Opened);
                    }
                    widget.delegate(options);
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
