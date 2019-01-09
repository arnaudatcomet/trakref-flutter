import 'package:flutter/material.dart';
import 'package:trakref_app/main.dart';

class AppOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
          child: Text(
            'Filters',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontFamily: 'SF Pro Text Regular',
            ),
          ),
          onPressed: () => print('hello'),
          borderSide: BorderSide(
              color: AppColors.lightGray,
              width: 0.3
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          )
      );
  }
}
