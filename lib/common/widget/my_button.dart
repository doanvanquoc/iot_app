//Dùng button này cho các button trong app, không cần tự custom
import 'package:flutter/material.dart';
import 'package:iot_app/common/app/app_color.dart';
import 'package:iot_app/common/app/app_style.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppStyle.buttonText,
      ),
    );
  }
}
