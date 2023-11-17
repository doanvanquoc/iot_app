import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationViewModel extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  var otpValues = List.filled(6, '').obs;

  void onOTPChanged(String value, int index, BuildContext buildContext) {
    otpValues[index] = value; // Update the OTP value

    if (value.length == 1 && index < 5) {
      FocusScope.of(buildContext).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(buildContext).previousFocus();
    }
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
