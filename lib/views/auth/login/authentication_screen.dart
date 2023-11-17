import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/views/auth/login/controllers/otp_field_controller.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final AuthenticationViewModel viewModel = Get.put(AuthenticationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Xác thực tài khoản',
          style: TextStyle(
            color: Color(0xff484D51),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          iconSize: 17,
          icon: const CircleAvatar(
            radius: 17,
            backgroundColor: AppColor.secondaryColor,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff484D51),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Nhập mã xác minh 6 chữ số đã được gửi đến số điện thoại của bạn',
                style: TextStyle(
                  height: 1.8,
                  color: Color(0xff484D51),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              OTPFieldController(),
              const SizedBox(height: 32),
              Obx(() =>
                  Text('Mã còn hiệu lực trong ${viewModel.timeLeft} giây')),
              const SizedBox(height: 20),
              Obx(
                () => TextButton(
                  onPressed: () {
                    viewModel.resendCode.value ? viewModel.ResendCode() : null;
                  },
                  child: Text(
                    'Gửi lại mã',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: viewModel.resendCode.value
                          ? const Color(0xffFF7B54)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 271),
              Obx(
                () => MyButton(
                    text: 'Đăng nhập',
                    onTap: viewModel.isOTPComplete
                        ? viewModel.checkOTPCompletion
                        : () {
                            Get.snackbar(
                              'Thông báo',
                              'Vui lòng điền đầy đủ mã OTP!',
                              colorText: AppColor.primaryColor,
                              backgroundColor: const Color(0xffDDE6ED),
                              snackPosition: SnackPosition.TOP,
                            );
                          }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
