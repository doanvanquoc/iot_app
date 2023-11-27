import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/country_phone_code.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/views/auth/login/authentication_screen.dart';
import 'package:iot_app/views/home/home_screen.dart';

class LoginViewModel extends GetxController {
  var selectedSegment = 1.obs;
  var selectedCountryCode = CountryPhoneCode.countryCodes[0].code.obs;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  bool get isPhoneComplete => phoneNumber.trim().isNotEmpty;
  bool get isEmailComplete => email.trim().isNotEmpty && isEmail;
  bool get isPasswordComplete => password.trim().isNotEmpty;
  int? idx;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var isSuccess = false.obs;
  RxBool isObs = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx<User?>(null);

  User? get user => _firebaseUser.value;

  final AuthenticationViewModel _auth = Get.put(AuthenticationViewModel());

  void onSegmentChanged(int newValue) {
    selectedSegment(newValue);
  }

  void selectCountryCode(String newValue) {
    selectedCountryCode(newValue);
  }

  bool get checkInPutCompletion {
    return selectedSegment.value == 1
        ? isPhoneComplete
        : (isEmailComplete && isPasswordComplete);
  }

  void sendOTP() {
    print('go to auth');
    AuthenticationRepository.instance.isLoading.value = false;
    Get.to(() => AuthenticationScreen(
        phoneNumber: '+84${phoneNumber.value.trim()}', idx: 1));
    _auth.startTime();
  }

  // void sendLink() {
  //   print('go to auth');
  //   Get.to(() => AuthenticationScreen(email: email.value.trim(), idx: 2));
  //   _auth.startTime();
  // }

  // void sendLink() {
  //   print('go to auth');
  //   Get.to(
  //     () => AuthenticationScreen(email: email.value.trim(), idx: 2),
  //   );
  //   _auth.startTime();
  // }

  // Future<bool> checkEmailExists(String email) {
  //   return AuthenticationRepository.instance.checkEmailExists(email);
  // }

  // void sendVerificationEmail() async {
  //   try {
  //     await auth.currentUser!.sendEmailVerification();
  //   } catch (e) {
  //     Get.snackbar(
  //       'Lỗi',
  //       'Không thể gửi email xác minh. Vui lòng thử lại sau.',
  //     );
  //   }
  // }

  void signInWithEmailAndPassword() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.value, password: password.value)
          .then((result) {
        isSuccess.value = true;
        // Get.offAll(() => const HomeScreen());
        // Get.snackbar(
        //   'Thông báo',
        //   'Đăng nhập thành công!',
        //   colorText: AppColor.primaryColor,
        //   backgroundColor: const Color(0xffDDE6ED),
        //   snackPosition: SnackPosition.TOP,
        // );
      });
    } catch (e) {
      Get.snackbar(
        'Thông báo',
        'Tài khoản không hợp lệ!',
        colorText: AppColor.primaryColor,
        backgroundColor: const Color(0xffDDE6ED),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Future<void> login() async {
  //   // try {
  //   //   sendLink();
  //   //   final auth = AuthenticationRepository.instance;
  //   //   await auth.loginWithEmailAndPassword(
  //   //       email.value.trim(), password.value.trim());
  //   // } catch (e) {
  //   //   print(e.toString());
  //   // }
  //   Get.to(() => const HomePage());
  // }

  bool get isEmail {
    const emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email.value);
  }
}
