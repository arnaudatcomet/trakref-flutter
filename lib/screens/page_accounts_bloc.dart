import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/repository/get_service.dart';
import 'package:trakref_app/screens/page_account_detail_bloc.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageAccountsBloc extends StatefulWidget {
  @override
  _PageAccountsBlocState createState() => _PageAccountsBlocState();
}

class _PageAccountsBlocState extends State<PageAccountsBloc> {
  AccountsService service = AccountsService();
  bool _onLoaded = false;

  // Properties
  List<ListItem> items = [
  ];

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
    service.onLoaded = () {
      setState(() {
        _onLoaded = true;
        for (Account acc in service.accounts) {
          items.add(AccountItem(acc.name));
        }
      });
    };
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            onPressed: () {},
          ),
        ]
      ),
      body: (_onLoaded == false) ? FormBuild.buildLoader() : Container(
        width: double.infinity,
        color: Colors.white,
        child: ListView.builder(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            itemCount: (items.length+1),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Select an account',
                      style: Theme.of(context).textTheme.title,
                    )
                  ],
                );
              }
              else {
                final item = items[index-1];
                if (item is AccountItem) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            Account acc = service.accounts[index-1];
                            return PageAccountDetailBloc(
                              accountName: acc.name
                            );
                          }
                        )
                      );
                    },
                    child: Container(
                      child: this.makeAccountTile(item),
                    ),
                  );
                }
              }
            }
        ),
      ),
    );
  }
}

class AccountItem implements ListItem {
  final String account;
  AccountItem(this.account);
}