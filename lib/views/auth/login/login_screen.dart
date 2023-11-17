import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/views/auth/login/authentication_screen.dart';
import 'package:iot_app/views/auth/login/controllers/phone_number_controller.dart';
import 'package:iot_app/views/auth/login/controllers/segmented_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel = Get.put(LoginViewModel());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
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
                  SegmentedController(viewModel: viewModel),
                  const SizedBox(height: 24),
                  Obx(() {
                    if (viewModel.selectedSegment.value == 1) {
                      return Row(
                        children: [
                          Expanded(
                            child: PhoneNumberController(),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 56,
                              child: TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                style: const TextStyle(
                                  color: Color(0xff484D51),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
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
                      );
                    } else {
                      return SizedBox(
                        height: 56,
                        child: TextFormField(
                          style: const TextStyle(
                            color: Color(0xff484D51),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'your_email@gmail.com',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 24),
                  MyButton(
                      text: 'Gửi mã OTP',
                      onTap: () {
                        Get.to(AuthenticationScreen());
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
