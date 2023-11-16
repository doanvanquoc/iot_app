import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/views/auth/login/login_view_model.dart';
import 'package:iot_app/views/auth/login/phone_number_control_widget.dart';

import 'segmented_control_widget.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel = Get.put(LoginViewModel());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7FBFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 2,
              color: AppColor.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Đăng Nhập Tài Khoản',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff484D51),
                      )),
                  const SizedBox(height: 24),
                  SegmentedControlWidget(viewModel: viewModel),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: PhoneNumberControlWidget(),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 56,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  MyButton(text: 'Gửi mã OTP', onTap: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
