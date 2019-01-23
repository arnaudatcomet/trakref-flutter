import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';
import 'package:trakref_app/screens/page_dashboard_bloc.dart';

class PageAccountsBloc extends StatefulWidget {
  @override
  _PageAccountsBlocState createState() => _PageAccountsBlocState();
}

class _PageAccountsBlocState extends State<PageAccountsBloc> {
  // Properties
  final List<ListItem> items = [
    AccountItem('10 Safeway Chicago Internal Provider'),
    AccountItem('20 North Refrigeration Inc.'),
    AccountItem('5-Star Refrigeration'),
    AccountItem('728 Source Refrigeration & HVAC Inc'),
    AccountItem('A M Refrigeration'),
    AccountItem('A Superior Service'),
    AccountItem('AAA - NY/NJ'),
    AccountItem('10 Safeway Chicago Internal Provider'),
    AccountItem('20 North Refrigeration Inc.'),
    AccountItem('5-Star Refrigeration'),
    AccountItem('728 Source Refrigeration & HVAC Inc'),
    AccountItem('A M Refrigeration'),
    AccountItem('A Superior Service'),
    AccountItem('AAA - NY/NJ'),
    AccountItem('10 Safeway Chicago Internal Provider'),
    AccountItem('20 North Refrigeration Inc.'),
    AccountItem('5-Star Refrigeration'),
    AccountItem('728 Source Refrigeration & HVAC Inc'),
    AccountItem('A M Refrigeration'),
    AccountItem('A Superior Service'),
    AccountItem('AAA - NY/NJ')
  ];

  ListTile makeAccountTile(AccountItem item) => ListTile(
      title: Text(
        item.account,
        style: Theme.of(context).textTheme.body1,
      ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: new Icon(Icons.close, color: AppColors.gray),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search, color: AppColors.gray),
            onPressed: () {},
          ),
        ]
      ),
      body: Container(
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
                  return new Container(
                    child: this.makeAccountTile(item),
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