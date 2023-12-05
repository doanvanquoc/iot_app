import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/country_phone_code.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';
import 'package:iot_app/views/auth/login/authentication_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends GetxController {
  var selectedSegment = 1.obs;
  var selectedCountryCode = CountryPhoneCode.countryCodes[0].code.obs;
  var isSuccess = false.obs;
  int? idx;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool isObs = true.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final AuthenticationViewModel _auth = Get.put(AuthenticationViewModel());
  bool get isPhoneComplete => phoneNumber.trim().isNotEmpty;
  bool get isEmailComplete => email.trim().isNotEmpty && isEmail;
  bool get isPasswordComplete => password.trim().isNotEmpty;
  User? get user => _firebaseUser.value;
  bool get checkInPutCompletion {
    return selectedSegment.value == 1
        ? (isEmailComplete && isPasswordComplete)
        : isPhoneComplete;
  }

  void onSegmentChanged(int newValue) {
    selectedSegment(newValue);
  }

  void selectCountryCode(String newValue) {
    selectedCountryCode(newValue);
  }

  void sendOTP() async {
    AuthenticationRepository.instance.isLoading.value = false;
    Get.to(() => AuthenticationScreen(
        phoneNumber: '+84${phoneNumber.value.trim()}', idx: 2));
    _auth.startTime();
  }
  
  bool get isEmail {
    const emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email.value);
  }

  void signInWithEmailAndPassword() async {
    try {
      var user = await AuthenticationRepository.instance
          .getUserByEmailAndPassword(email.value, password.value);
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userData = jsonEncode(user.toJson());
        await prefs.setString('userData', userData);
        isSuccess.value = true;
        GlobalModel.instance.setAuthenticatedUser(user);
      }
    } catch (e) {
      Get.snackbar(
        'Thông báo',
        'Đã xảy ra lỗi. Vui lòng thử lại sau!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
