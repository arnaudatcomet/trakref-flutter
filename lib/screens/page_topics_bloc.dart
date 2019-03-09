import 'package:flutter/material.dart';

//class TopicItem extends StatelessWidget {
//  final String image = "";
//  final String title = "";
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Image.asset("assets/images/security-account.png",
//            width: 160,
//            alignment: Alignment.centerLeft,
//            fit: BoxFit.fitHeight),
//        Text('This is # $index',
//            style: Theme.of(context).textTheme.body1)
//      ],
//    );
//  }
//}

class PageTopicsBloc extends StatefulWidget {
  @override
  _PageTopicsBlocState createState() => _PageTopicsBlocState();
}

class _PageTopicsBlocState extends State<PageTopicsBloc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          new Container(
            child: new Text("What's the topic?",
                style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.left,
            )
          ),
          SizedBox(
            height: 50,
          ),
          Text("Give us some information to help us to treat your demand quickly.",
          style: Theme.of(context).textTheme.body1
          ),
          GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(4, (index) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    Image.asset("assets/images/security-account.png",
                        width: 160,
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.fitHeight),
                    Text('This is # $index',
                    style: Theme.of(context).textTheme.body1)
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
