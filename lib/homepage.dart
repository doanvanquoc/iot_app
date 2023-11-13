import 'package:flutter/material.dart';
import 'package:iot_app/common/app_color.dart';
import 'package:iot_app/common/app_style.dart';
import 'package:iot_app/common/my_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Appbar',
          style: AppStyle.appBarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              color: AppColor.primaryColor.withOpacity(0.8),
            ),
            const Text('Đăng Nhập Tài Khoản', style: AppStyle.appBarText),
            const MyButton(text: 'Đăng Nhập'),
          ],
        ),
      ),
    );
  }
}
