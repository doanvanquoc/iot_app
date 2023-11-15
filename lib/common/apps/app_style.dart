import 'package:flutter/material.dart';

class AppStyle {
  static const appBarText = TextStyle(
    color: Color(0xff484D51),
    fontSize: 24,
  ); // Style text appbar

  static const onImagePrimaryText = TextStyle(
    color: Color(0xffF7FBFC),
    fontSize: 14,
  ); // Style text cho text nằm trên ảnh, dòng 1
  static const onImageSecondaryText = TextStyle(
    color: Color(0xffF7FBFC),
    fontSize: 12,
  ); // Style text cho text nằm trên ảnh, dòng 2

  static const onCardPrimaryText = TextStyle(
    color: Color(0xff484D51),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const onCardSecondaryText = TextStyle(
    color: Color(0xff484D51),
    fontSize: 15,
    // fontWeight: FontWeight.bold,
  );

  static const buttonText = TextStyle(
    color: Color(0xffF7FBFC),
    fontSize: 16,
    // fontWeight: FontWeight.w700,
  );
}

//HDSD => Text('AppBar Text', style: AppStyle.appBarPrimaryText)
