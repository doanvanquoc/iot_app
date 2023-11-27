import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/my_app.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/views/auth/login/login_screen.dart';
import 'package:iot_app/views/home/home_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  static LoginViewModel viewModel = Get.put(LoginViewModel());

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationID = ''.obs;
  int? _forceResendingToken;
  var isLoading = false.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    //ever(firebaseUser, _setInitialScreen);
    setInitialScreen(firebaseUser.value);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => LoginScreen())
        : Get.offAll(() => const NavScreen());
    //: Get.offAll(() => AuthenticationScreen(idx: 2));
  }

  Future<void> phoneNumberAuthentication(String phoneNo) async {
    isLoading.value = true;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) {
        //await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          isLoading.value = false;
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

  // void sendSignInLinkToEmail(String email) async {
  //   final ActionCodeSettings actionCodeSettings = ActionCodeSettings(
  //     url:
  //         'https://smarthome-arduino-53a4f.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
  //     handleCodeInApp: true,
  //     iOSBundleId: 'com.example.ios',
  //     androidPackageName: 'com.example.android',
  //     androidInstallApp: true,
  //     androidMinimumVersion: '12',
  //   );

  //   await _auth.sendSignInLinkToEmail(
  //     email: email,
  //     actionCodeSettings: actionCodeSettings,
  //   );
  // }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('...');
      throw Exception(e.code);
    }
  }

  // Future<void> sendEmailVerification() async {
  //   // if (!await emailVerified()) {
  //   //   print('athued');
  //   //   try {
  //   //     await _auth.currentUser!.sendEmailVerification();
  //   //   } catch (e) {
  //   //     print(e);
  //   //   }
  //   // } else {
  //   //   Get.to(() => const HomePage());
  //   // }
  //   try {
  //     print('send');
  //     await _auth.currentUser!.sendEmailVerification();
  //   } on FirebaseAuthException catch (e) {
  //     print(e.toString());
  //   }
  // }

//   void emailAuthentication(String email) async {
//   try {
//     sendSignInLinkToEmail(email);
//   } catch (e) {
//     Get.snackbar(
//       'Thông báo',
//       'Không thể gửi email xác thực: ${e.toString()}',
//       colorText: AppColor.primaryColor,
//       backgroundColor: const Color(0xffDDE6ED),
//       snackPosition: SnackPosition.TOP,
//     );
//   }
// }

  // Future<bool> checkEmailExists(String email) async {
  //   try {
  //     var methods =
  //         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //     return methods.isNotEmpty;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> emailVerified() async {
  //   User? user = _auth.currentUser;
  //   if (user == null) {
  //     Get.snackbar(
  //       'Thông báo',
  //       'Email không hợp lệ!',
  //       colorText: AppColor.primaryColor,
  //       backgroundColor: const Color(0xffDDE6ED),
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return false;
  //   }
  //   print('have acc');
  //   viewModel.sendLink();
  //   await user.reload();
  //   user = _auth.currentUser;
  //   return user?.emailVerified ?? false;
  // }

  // Future<void> sendMail() async {
  //   try {
  //     await _auth.currentUser?.sendEmailVerification();
  //   } on FirebaseException catch (e) {
  //     throw e.toString();
  //   }
  // }
}
