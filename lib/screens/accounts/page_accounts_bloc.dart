import 'package:flutter/material.dart';
import 'package:trakref_app/bloc/accounts_bloc.dart';
import 'package:trakref_app/bloc/bloc_provider.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
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

enum PageAccountsType {
  Details,
  Home
}

class PageAccountsBloc extends StatefulWidget {
  final int currentInstanceID;
  final PageAccountsType type;
  PageAccountsBloc({this.currentInstanceID, this.type});

  @override
  _PageAccountsBlocState createState() => _PageAccountsBlocState();
}

class _PageAccountsBlocState extends State<PageAccountsBloc> {
  TrakrefAPIService api = TrakrefAPIService();
  List<Account> accounts;
  bool _onLoaded = false;
  bool _activeState;
  TextEditingController _controller;
  FocusNode _textFocus;

  // BLoC
  AccountsBloc accountBloc;

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

  @override
  void dispose() {
    api.close();
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

    // Link to AccountBloc
    this.accountBloc = BlocProvider.of<AccountsBloc>(context);

    api.getAccounts().then((results) {
      if (results == null) {
        FormBuild.showFlushBarMessage(context, "Error when retrieving all the accounts", (){
          Navigator.of(context).pop();
        });
      }
      else {
        // Add accounts retrieved and prepare the list view
        accounts = results;
        print("getRetrievingAccount retrieved ${accounts.length} accounts");
        for (Account acc in accounts) {
          items.add(AccountItem(account: acc.name, accountID: acc.instanceID));
        }
      }

      // Notify to stop loading
      setState(() {
        _onLoaded = true;
      });
    }).catchError((error){
      FormBuild.showFlushBarMessage(context, error, (){
        Navigator.of(context).pop();
      });
    });

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
              leading: (widget.type == PageAccountsType.Home) ? Container() : IconButton(
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
                            Account selectedAccount = accounts.where((Account account) => account.instanceID == item.accountID).first;
                            // Show the details
                            print("widget.type ${widget.type}");
                            // Save the instanceID and selected account
                            TrakrefAPIService().setSelectedAccount(selectedAccount);
                            TrakrefAPIService().setInstanceID(selectedAccount.instanceID.toString());

                            if (widget.type == PageAccountsType.Details) {
//                              Navigator.of(context).push(MaterialPageRoute(
//                                  builder: (BuildContext context) {
//                                    return PageAccountDetailBloc(
//                                        account: selectedAccount);
//                                  }));
                            Navigator.of(context).pop();
                            }
                            // Show the home page
                            else if (widget.type == PageAccountsType.Home) {
                              Navigator.of(context).pushNamed("/home");
                            }
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
