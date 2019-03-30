import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final String image = "";
  int index = -1;
  final String title = "";

  TopicItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(TopicItem.getImagePath(this.index),
              width: 160,
              alignment: Alignment.centerLeft,
              fit: BoxFit.fitHeight),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Text(
                    "This is"
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    /* Container(
      child: Stack(
        children: <Widget>[
          Image.asset(TopicItem.getImagePath(this.index),
              width: 160,
              alignment: Alignment.centerLeft,
              fit: BoxFit.fitHeight),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(getTitle(this.index,),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.body1),
            ),
          ),

        ],
      ),
    );*/
  }

  static String getImagePath(int index) {
    switch (index) {
      case 0:
        return "assets/images/feature-request.png";
        break;
      case 1:
        return "assets/images/usage-training.png";
        break;
      case 2:
        return "assets/images/security-account.png";
        break;
      case 3:
        return "assets/images/something-else.png";
        break;
    }
    return "assets/images/security-account.png";
  }

  static String getTitle(int index) {
    switch (index) {
      case 0:
        return "Feature Request";
        break;
      case 1:
        return "Usage, Training";
        break;
      case 2:
        return "Security, Your account";
        break;
      case 3:
        return "It is something else";
        break;
    }
    return "Feature Request";
  }
}

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
              return TopicItem(index);
//              return Container(
//                child: Stack(
//                  children: <Widget>[
//                    Image.asset("assets/images/security-account.png",
//                        width: 160,
//                        alignment: Alignment.centerLeft,
//                        fit: BoxFit.fitHeight),
//                    Text('This is # $index',
//                    style: Theme.of(context).textTheme.body1)
//                  ],
//                ),
//              );
            }),
          )
        ],
      ),
    );
  }
}
