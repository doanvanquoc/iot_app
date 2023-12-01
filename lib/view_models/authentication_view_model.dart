import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/user.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';
import 'package:iot_app/views/auth/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationViewModel extends GetxController {
  static LoginViewModel viewModel = Get.put(LoginViewModel());
  static AuthenticationViewModel get instance =>
      Get.put(AuthenticationViewModel());

  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  var otpValues = List.filled(6, '').obs;
  var timeLeft = 60.obs;
  var isSuccess = false.obs;
  Timer? _timer;
  RxBool resCode = false.obs;
  bool get isOTPComplete =>
      otpValues.every((value) => value.trim().length == 1);
  Rx<User?> firebaseUser = Rx<User?>(null);

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

  void resetOTPFields() {
    otpValues.value = List.filled(6, '');
    otpControllers = List.generate(6, (index) => TextEditingController());
  }

  void phoneAuthentification(String phoneNo) {
    resetOTPFields();
    AuthenticationRepository.instance.phoneNumberAuthentication(phoneNo);
  }

  Future<UserModel?> getUserByPhoneNo(String phoneNumber) async {
    try {
      var usersRef = FirebaseFirestore.instance.collection('users');
      var querySnapshot =
          await usersRef.where('phoneNo', isEqualTo: phoneNumber).get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        return UserModel.fromMap(userData);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void verifyOTP() async {
    var otp = otpValues.join();
    var isVerify = await AuthenticationRepository.instance.verifyOTP(otp);

    if (isVerify) {
      isSuccess.value = true;
      var loginViewModel = Get.find<LoginViewModel>();
      var normalizedPhoneNo =
          AuthenticationRepository.instance.normalizePhoneNumber(
        loginViewModel.phoneNumber.value,
        loginViewModel.selectedCountryCode.value,
      );

      var userResult = await AuthenticationRepository.instance
          .getUserByPhoneNo(normalizedPhoneNo);

      if (userResult != null) {
        print('verifyOTP: $userResult');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userData = jsonEncode(userResult.toJson());
        await prefs.setString('userData', userData);

        GlobalModel.instance.setAuthenticatedUser(userResult);
      } else {
        print('error:');
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

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Bạn chắc chắn muốn đăng xuất?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Đăng xuất'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                isSuccess.value = false;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('userData');
                firebaseUser.value = null;
                Get.offAll(() => LoginScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
