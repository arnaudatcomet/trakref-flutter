import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/workorder.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/screens/home/page_dashboard_bloc.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';


typedef SelectCurrentWorkOrderDelegate = void Function(WorkOrder selectedWorkOrder);

class PageSelectCurrentWorkOrderBloc extends StatefulWidget {
  WorkOrder selectedWorkOrder;
  SelectCurrentWorkOrderDelegate delegate;
  PageSelectCurrentWorkOrderBloc({this.selectedWorkOrder, this.delegate});

  @override
  _PageSelectCurrentWorkOrderBlocState createState() => _PageSelectCurrentWorkOrderBlocState();
}

class _PageSelectCurrentWorkOrderBlocState extends State<PageSelectCurrentWorkOrderBloc> {
  bool _isWorkOrdersLoaded;
  List<WorkOrder> _workOrdersResult = [];
  List<WorkOrder> _searchWorkOrdersResult = [];

  bool _searchIsActiveState = false;
  TextEditingController _controller;
  FocusNode _textFocus;

  TrakrefAPIService api = TrakrefAPIService();

  @override
  void initState() {
    _controller = TextEditingController();
    _textFocus = FocusNode();
    _controller.addListener(onChange);
    _textFocus.addListener(onChange);
    _isWorkOrdersLoaded = false;

    api.getServiceEvents([]).then((workOrders) {
      _isWorkOrdersLoaded = true;
      setState(() {
        _workOrdersResult = workOrders;
      });
    }).catchError((error){
      _isWorkOrdersLoaded = false;
    });
    super.initState();
  }

  Widget buildTextfieldRow(String key, String label, String initialValue) {
    if (initialValue == null) {
      return Row(mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FormBuild.buildTextField(key: Key(key), label: label)
          ]
      );
    }
    return Row(mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FormBuild.buildTextField(key: Key(key), label: label, initialValue: initialValue)
        ]
    );
  }

  // Renderer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (_searchIsActiveState == true)
        ? AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: TextFormField(
        focusNode: _textFocus,
        controller: _controller,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(Icons.clear,
                    color: AppColors.gray),
                onPressed: () {
                  setState(() {
                    _controller.clear();
                    _searchIsActiveState = false;
                  });
                }),
            icon: Icon(Icons.search, color: AppColors.gray),
            hintText: "Search for a work order"),
      ),
    )
        : AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: new Icon(Icons.close, color: AppColors.gray),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search, color: AppColors.gray),
            onPressed: () {
              setState(() {
                // Clear the search results
                _searchWorkOrdersResult = [];
                _searchIsActiveState = true;
              });
            },
          ),
        ]),
        backgroundColor: Colors.white,
        body: (_isWorkOrdersLoaded == false)
            ? FormBuild.buildLoader()
            : Container(
          width: double.infinity,
          color: Colors.white,
          child: ListView.builder(
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              itemCount: (_searchIsActiveState == false) ? (_workOrdersResult.length) : (_searchWorkOrdersResult.length),
              itemBuilder: (context, index) {
                if (index == 0 && (_searchIsActiveState == false)) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Select Work Order',
                        style: Theme.of(context).textTheme.title,
                      )
                    ],
                  );
                }
                else {
                  final item = (_searchIsActiveState == false) ? _workOrdersResult[index] : _searchWorkOrdersResult[index];
                  return InkWell(
                    onTap: () {
                      WorkOrder selectedWorkOrder = _workOrdersResult.where((WorkOrder order) => order.id == item.id).first;
                      widget.delegate(selectedWorkOrder);
                      Navigator.of(context).pop();
                    },
                    child: ServiceEventCellWidget(
                        order: item
                    ),
                  );
                }
              }),
        )
    );
  }

  // Handling the search functions
  void onChange(){
    String text = _controller.text.toLowerCase();
    bool hasFocus = _textFocus.hasFocus;

    _searchWorkOrdersResult.clear();

    print("onSearchTextChanged $text");

    if (text.isNotEmpty) {
      _workOrdersResult.forEach((workOrder){
        if (workOrder.workOrderNumber.toLowerCase().contains(text) ||
            workOrder.location.toLowerCase().contains(text) ||
            workOrder.instance.toLowerCase().contains(text)) {
          _searchWorkOrdersResult.add(workOrder);
        }
      });
    }
    setState(() {});
  }
}
