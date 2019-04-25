import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api_service.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/screens/settings/account_detail/page_account_detail_bloc.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

// Animation Widget
//class AnimationFade extends StatelessWidget {
//  final Widget child;
//  final TickerProvider vsync;
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}


class PageAccountsBloc extends StatefulWidget {
  @override
  _PageAccountsBlocState createState() => _PageAccountsBlocState();
}

class _PageAccountsBlocState extends State<PageAccountsBloc> {
  ApiService api = ApiService();
  List<Account> accounts;
  bool _onLoaded = false;
  bool _activeState;
  TextEditingController _controller;
  FocusNode _textFocus;

  // Properties
  List<ListItem> items = [];
  List<ListItem> _searchResult = [];


  ListTile makeAccountTile(AccountItem item) =>
      ListTile(
        title: Text(
          item.account,
          style: Theme
              .of(context)
              .textTheme
              .body1,
        ),
      );

  // API Service calls
  void getAccounts() {
    var baseUrl = "https://api.trakref.com/v3.21/accounts";
    api.getResult<Account>(baseUrl).then((results) {
      // Add accounts retrieved and prepare the list view
      accounts = results;
      for (Account acc in accounts) {
        items.add(AccountItem(account: acc.name, accountID: acc.instanceID));
      }

      // Notify to stop loading
      setState(() {
        _onLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _onLoaded = false;
    _activeState = false;
    _controller = TextEditingController();
    _textFocus = FocusNode();

    _controller.addListener(onChange);
    _textFocus.addListener(onChange);

    // Get the list of accounts
    getAccounts();

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
                  itemCount: (_activeState == true) ? (_searchResult.length) : (items.length + 1),
                  itemBuilder: (context, index) {
                    if (index == 0 && (_activeState == false)) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Select an account',
                            style: Theme.of(context).textTheme.title,
                          )
                        ],
                      );
                    }
                    else {
                      final item = (_activeState == true) ? _searchResult[index] : items[index - 1];
                      if (item is AccountItem) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              Account selectedAccount = accounts.where((Account account) => account.instanceID == item.accountID).first;
                              return PageAccountDetailBloc(
                                  account: selectedAccount);
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
