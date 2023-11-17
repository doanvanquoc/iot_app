import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/room/room_screen.dart';

class AuthenticationViewModel extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  var otpValues = List.filled(6, '').obs;
  var timeLeft = 60.obs;
  Timer? _timer;
  RxBool resendCode = false.obs;
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
    resendCode.value = false;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
      } else {
        timer.cancel();
        resendCode.value = true;
      }
    });
  }

  void ResendCode() {
    startTime();
  }

  void checkOTPCompletion() {
    if (isOTPComplete) {
      Get.to(const HomePage());
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
