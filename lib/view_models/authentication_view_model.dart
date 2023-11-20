import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/views/room/room_screen.dart';

class AuthenticationViewModel extends GetxController {
  static AuthenticationViewModel get instance => Get.find();
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  void phoneAuthentification(String phoneNo) {
    AuthenticationRepository.instance.phoneNumberAuthentication(phoneNo);
  }

  void verifyOTP() async {
    var otp = otpValues.join();
    var isVerify = await AuthenticationRepository.instance.verifyOTP(otp);

    if (isVerify) {
      Get.offAll(() => const HomePage());
    } else {
      Get.snackbar(
        'Thông báo',
        'OTP không hợp lệ!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  var otpValues = List.filled(6, '').obs;
  var timeLeft = 60.obs;
  Timer? _timer;
  RxBool resCode = false.obs;
  bool get isOTPComplete =>
      otpValues.every((value) => value.trim().length == 1);

  void onOTPChanged(String value, int index, BuildContext buildContext) {
    otpValues[index] = value;

    if (value.length == 1 && index < 5) {
      FocusScope.of(buildContext).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(buildContext).previousFocus();
    }
  }

  void startTime() {
    timeLeft.value = 60;
    resCode.value = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
      } else {
        timer.cancel();
        resCode.value = true;
      }
    });
  }

  void resendCode(String phoneNo) {
    phoneAuthentification(phoneNo);
    startTime();
  }

  Future<void> checkOTPCompletion() async {
    if (timeLeft > 0) {
      if (isOTPComplete) {
        verifyOTP();
      } else {
        Get.snackbar(
          'Thông báo',
          'Vui lòng điền đầy đủ mã OTP!',
          colorText: AppColor.primaryColor,
          backgroundColor: const Color(0xffDDE6ED),
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        'Thông báo',
        'OTP không hợp lệ!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    startTime();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }
}
