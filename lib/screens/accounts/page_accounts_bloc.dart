import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/screens/accounts/page_account_detail_bloc.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAccountsBloc extends StatefulWidget {
  @override
  _PageAccountsBlocState createState() => _PageAccountsBlocState();
}

class _PageAccountsBlocState extends State<PageAccountsBloc> {
  AccountsService service = AccountsService();
  bool _onLoaded = false;
  bool _activeState;
  TextEditingController _controller;
  FocusNode _textFocus;

  // Properties
  List<ListItem> items = [];
  List<ListItem> _searchResult = [];


  ListTile makeAccountTile(AccountItem item) => ListTile(
        title: Text(
          item.account,
          style: Theme.of(context).textTheme.body1,
        ),
      );

  @override
  void initState() {
    service.loadAccounts();
    _onLoaded = false;
    _activeState = false;
    _controller = TextEditingController();
    _textFocus = FocusNode();

    _controller.addListener(onChange);
    _textFocus.addListener(onChange);

    // Load the whole page when the service is loading
    service.onLoaded = () {
      setState(() {
        _onLoaded = true;
        for (Account acc in service.accounts) {
          items.add(AccountItem(account: acc.name, accountID: acc.instanceID));
        }
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_activeState == true)
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
                            _activeState = false;
                          });
                        }),
                    icon: Icon(Icons.search, color: AppColors.gray),
                    hintText: "Search for an account"),
              ),
      )
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: new Icon(Icons.close, color: AppColors.gray),
                onPressed: () {
//            Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.search, color: AppColors.gray),
                    onPressed: () {
                      setState(() {
                        _activeState = true;
                      });
                    },
                  ),
                ]),
      body: (_onLoaded == false)
          ? FormBuild.buildLoader()
          : Container(
              width: double.infinity,
              color: Colors.white,
              child: ListView.builder(
                  padding: EdgeInsets.all(5),
                  shrinkWrap: true,
                  itemCount: (_activeState == true) ? (_searchResult.length + 1) : (items.length + 1),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Select an account',
                            style: Theme.of(context).textTheme.title,
                          )
                        ],
                      );
                    } else {
                      final item = (_activeState == true) ? _searchResult[index - 1] : items[index - 1];
                      if (item is AccountItem) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              Account acc = service.accounts[index - 1];
                              return PageAccountDetailBloc(
                                  accountName: acc.name);
                            }));
                          },
                          child: Container(
                            child: this.makeAccountTile(item),
                          ),
                        );
                      }
                    }
                  }),
            ),
    );
  }

  // Handling the search functions
  void onChange(){
    String text = _controller.text;
    bool hasFocus = _textFocus.hasFocus;

    _searchResult.clear();

    print("onSearchTextChanged $text");

    items.forEach((accountDetail) {
      if (accountDetail is AccountItem) {
        if (accountDetail.account.contains(text)) {
          print("> Found ${accountDetail.account}");
          _searchResult.add(accountDetail);
        }
      }
    });
    setState(() {});
  }
}

class AccountItem implements ListItem {
  final String account;
  final int accountID;

  AccountItem({this.account, this.accountID});
}
