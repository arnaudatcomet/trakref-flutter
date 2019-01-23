import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(70)
            )
        ),
        Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: new Image.asset("assets/images/old-logo.png",
                          height: 50,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fitHeight),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 50,
                    ),
                    Text('Loading...',
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: "SF Pro Text Regular",
                          fontSize: 17
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}