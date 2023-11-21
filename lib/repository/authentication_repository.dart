import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/views/auth/login/login_screen.dart';
import 'package:iot_app/views/room/room_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  static LoginViewModel viewModel = Get.put(LoginViewModel());

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationID = ''.obs;
  int? _forceResendingToken;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginScreen())
        : Get.offAll(() => const HomePage());
  }

  Future<void> phoneNumberAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) {
        //await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar(
            'Thông báo',
            'Số điện thoại đăng nhập không hơp lệ!',
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
        //6throw Exception(e.message);
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
  }

  // Future<bool> verifyOTP(String otp) async {
  //   var credentials = await _auth.signInWithCredential(
  //       PhoneAuthProvider.credential(
  //           verificationId: verificationID.value, smsCode: otp));

  //   return credentials.user != null;
  // }

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
}
