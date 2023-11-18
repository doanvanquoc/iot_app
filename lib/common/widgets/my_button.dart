//Dùng button này cho các button trong app, không cần tự custom
import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    this.bgColor = AppColor.primaryColor,
    this.textStyle = AppStyle.buttonText,
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;
  final Color bgColor;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
