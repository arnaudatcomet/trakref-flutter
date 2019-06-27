import 'package:flutter/material.dart';
import 'package:trakref_app/enums/viewstate.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/models/account.dart';
import 'package:trakref_app/screens/base_view.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/viewmodel/accounts_model.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

enum PageAccountsType { Details, Home }

class PageAccountsBloc extends StatefulWidget {
  final PageAccountsType type;
  PageAccountsBloc({this.type});

  @override
  _PageAccountsBlocState createState() => _PageAccountsBlocState();
}

class _PageAccountsBlocState extends State<PageAccountsBloc> {
  bool _searchIsActive;
  TextEditingController _controller;
  FocusNode _textFocus;

  // Properties
  List<ListItem> _searchResult = [];

  ListTile makeAccountTile(AccountItem item) => ListTile(
        title: Text(
          item.account,
          style: Theme.of(context).textTheme.body1,
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _searchIsActive = false;
    _controller = TextEditingController();
    _textFocus = FocusNode();

    super.initState();
  }

  Widget searchInactiveAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: TextFormField(
        focusNode: _textFocus,
        controller: _controller,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: AppColors.gray),
                onPressed: () {
                  setState(() {
                    _searchIsActive = false;
                  });
                }),
            icon: Icon(Icons.search, color: AppColors.gray),
            hintText: "Search for an account"),
      ),
    );
  }

  Widget searchActiveAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: (widget.type == PageAccountsType.Home)
            ? Container()
            : IconButton(
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
                _searchIsActive = true;
              });
            },
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountsModel>(
      onModelReady: (model) {
        model.fetchAccounts().then((results) {
          model.controller = _controller;
          model.controller.addListener(() {
            _searchResult = model
                .fetchFromSearch(model.accounts, _controller.text)
                .map((item) =>
                    AccountItem(account: item.name, accountID: item.ID))
                .toList();
            setState(() {});
          });
        });
      },
      builder: (context, model, child) {
        var accountListView = ListView.builder(
            itemBuilder: (context, index) {
              Account item = model.accounts[index];
              AccountItem tile =
                  AccountItem(account: item.name, accountID: item.ID);

              if (_searchIsActive == true) {
                tile = _searchResult[index];
                print("search is active ${tile.account}");
              }
              return InkWell(
                  onTap: () {
                    print("select itemID is ${item.instanceID}");
                    model.selectAccount(item.instanceID);
                    if (widget.type == PageAccountsType.Details) {
                        Navigator.of(context).pop();
                    } else if (widget.type == PageAccountsType.Home) {
                      // Show the home page
                      Navigator.of(context).pushNamed("/home");
                    }
                  },
                  child: this.makeAccountTile(tile));
            },
            itemCount: (_searchIsActive == false)
                ? (model.accounts ?? []).length
                : _searchResult.length);
        return Scaffold(
          appBar: (!_searchIsActive)
              ? searchActiveAppBar()
              : searchInactiveAppBar(),
          backgroundColor: Colors.white,
          body: model.state == ViewState.Busy
              ? FormBuild.buildLoader()
              : RefreshIndicator(
                  color: AppColors.blueTurquoise,
                  child: accountListView,
                  onRefresh: () {
                    model.refreshAccounts();
                  },
                ),
        );
      },
    );
  }
}

class AccountItem implements ListItem {
  final String account;
  final int accountID;

  AccountItem({this.account, this.accountID});
}
