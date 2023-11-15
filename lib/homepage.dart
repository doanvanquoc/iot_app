import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/common/widgets/my_card.dart';
import 'package:lottie/lottie.dart';

import 'common/apps/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool value = false;
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
            MyCard(
              value: value,
              deviceName: 'diviceName',
              area: 'area',
              icon: Icons.face_unlock_outlined,
              onChanged: (val) {
                showModalBottomSheet(
                    context: context, builder: (context) => const Text('data'));
                setState(() {
                  value = val;
                });
              },
            ),
            const SizedBox(height: 20),
            MyButton(
                text: 'Gửi mã OTP',
                onTap: () {
                  log('abc');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset('assets/lotties/checked.json',
                                      width: 100, height: 100),
                                  const Text(
                                    'Đăng Nhập Thành Công',
                                    style: AppStyle.appBarText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
