import 'package:flutter/material.dart';
import 'package:trakref_app/repository/api/trakref_api_service.dart';
import 'package:trakref_app/widget/dropdown_widget.dart';

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    TrakrefAPIService().getAuthentificationToken().then((token){
      if (token == null) {
        Navigator.of(context).pushNamed("/login");
      }
      else {
        Navigator.of(context).pushNamed("/home");
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: FormBuild.buildLoader(),
    );
  }
}
