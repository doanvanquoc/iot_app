import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/my_app.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/views/auth/login/widgets/otp_wiget.dart';
import 'package:lottie/lottie.dart';

class AuthenticationScreen extends StatelessWidget {
  final AuthenticationViewModel viewModel = Get.put(AuthenticationViewModel());

  final String? phoneNumber;
  final int idx;

  AuthenticationScreen({Key? key, this.phoneNumber, required this.idx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: const Color(0xffF7FBFC),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(children: [
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
              OTPField(idx: 1),
              const SizedBox(height: 32),
              Obx(() =>
                  Text('Mã còn hiệu lực trong ${viewModel.timeLeft} giây')),
              const SizedBox(height: 20),
              Obx(
                () => TextButton(
                  onPressed: () {
                    viewModel.resCode.value
                        ? viewModel.resendCode(phoneNumber!)
                        : null;
                  },
                  child: Text(
                    'Gửi lại mã',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: viewModel.resCode.value
                          ? const Color(0xffFF7B54)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 271),
              MyButton(
                text: 'Đăng nhập',
                onTap: viewModel.checkOTPCompletion,
              ),
            ]),
          ),
        ),
      ),
      Obx(() {
        if (viewModel.isSuccess.value) {
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAll(() => const NavScreen());
          });
          return Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Lottie.asset('assets/lotties/success.json'),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    ]);
  }
}
