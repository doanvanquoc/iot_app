import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/user.dart';
import 'package:iot_app/my_app.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';
import 'package:iot_app/views/auth/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  AuthenticationRepository() {
    firebaseUser = Rx<User?>(_auth.currentUser);
  }
  static LoginViewModel viewModel = Get.put(LoginViewModel());

  final _auth = FirebaseAuth.instance;
  final user = Rx<UserModel?>(null);
  late Rx<User?> firebaseUser;
  var verificationID = ''.obs;
  var isLoading = false.obs;
  int? _forceResendingToken;

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen();
  }

  Future<void> setInitialScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('userData');

    if (userData != null) {
      UserModel user = UserModel.fromJson(jsonDecode(userData));
      GlobalModel.instance.setAuthenticatedUser(user);
      Get.offAll(() => const NavScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  String normalizePhoneNumber(String phoneNo, String selectedCountryCode) {
    String countryCode = selectedCountryCode.replaceAll('+', '');
    String normalized = phoneNo.replaceAll(RegExp(r'\D'), '');

    if (normalized.startsWith('0')) {
      normalized = normalized.substring(1);
    }
    if (!normalized.startsWith(countryCode)) {
      normalized = countryCode + normalized;
    }

    return normalized;
  }

  String normalizePhoneNumberForOTP(
      String phoneNo, String selectedCountryCode) {
    String normalized = normalizePhoneNumber(phoneNo, selectedCountryCode);
    return '+$normalized';
  }

  Future<UserModel?> getUserByPhoneNo(String phoneNo) async {
    try {
      var usersRef = FirebaseFirestore.instance.collection('users');
      String normalizedPhoneNo =
          normalizePhoneNumber(phoneNo, viewModel.selectedCountryCode.value);
      var querySnapshot =
          await usersRef.where('phoneNo', isEqualTo: normalizedPhoneNo).get();

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

  Future<void> phoneNumberAuthentication(String phoneNo) async {
    String normalizedPhoneNo = normalizePhoneNumberForOTP(
        phoneNo, viewModel.selectedCountryCode.value);
    UserModel? user = await getUserByPhoneNo(normalizedPhoneNo);
    print('phoneNumberAuthentication: $user');
    print(normalizedPhoneNo);

    if (user != null) {
      isLoading.value = true;
      await _auth.verifyPhoneNumber(
        phoneNumber: normalizedPhoneNo,
        verificationCompleted: (credential) {},
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          if (e.code == 'invalid-phone-number') {
            Get.snackbar(
              'Thông báo',
              'Số điện thoại đăng nhập không hơp lệ!',
              colorText: AppColor.primaryColor,
              backgroundColor: const Color(0xffDDE6ED),
              snackPosition: SnackPosition.TOP,
            );
          } else if (e.code == 'too-many-requests') {
            Get.snackbar(
              'Thông báo',
              'Đã xảy ra lỗi. Vui lòng thử lại sau!',
              colorText: AppColor.primaryColor,
              backgroundColor: const Color(0xffDDE6ED),
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Thông báo',
              'Vui lòng điền đầy đủ thông tin!',
              colorText: AppColor.primaryColor,
              backgroundColor: const Color(0xffDDE6ED),
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        codeSent: ((verificationId, forceResendingToken) {
          verificationID.value = verificationId;
          _forceResendingToken = forceResendingToken;
          viewModel.sendOTP();
        }),
        codeAutoRetrievalTimeout: ((verificationId) {
          verificationID.value = verificationId;
        }),
        forceResendingToken: _forceResendingToken,
      );
    } else {
      Get.snackbar(
        'Thông báo',
        'Tài khoản không hợp lệ!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value,
        smsCode: otp,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user != null;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> getUserByEmailAndPassword(
      String email, String password) async {
    var usersRef = FirebaseFirestore.instance.collection('users');
    try {
      var querySnapshot = await usersRef.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        if (userData['password'] == password) {
          return UserModel.fromMap(userData);
        }
      }
      Get.snackbar(
        'Thông báo',
        'Tài khoản không hợp lệ!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
      return null;
    } catch (e) {
      Get.snackbar(
        'Thông báo',
        'Đã xảy ra lỗi. Vui lòng thử lại sau!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
      return null;
    }
  }
}
