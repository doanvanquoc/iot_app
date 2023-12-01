import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/user.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserViewModel extends GetxController {
  var isDataChanged = false.obs;
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    final UserModel? currentUser = GlobalModel.instance.authenticatedUser.value;
    fullNameController = TextEditingController(text: currentUser?.fullname);
    emailController = TextEditingController(text: currentUser?.email);
    phoneController = TextEditingController(text: currentUser?.phoneNo);
    passwordController = TextEditingController(text: currentUser?.password);

    fullNameController.addListener(checkForChanges);
    emailController.addListener(checkForChanges);
    phoneController.addListener(checkForChanges);
    passwordController.addListener(checkForChanges);
  }
  
  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void checkForChanges() {
    var currentUser = GlobalModel.instance.authenticatedUser;
    isDataChanged.value =
        fullNameController.text != currentUser.value?.fullname ||
            emailController.text != currentUser.value?.email ||
            phoneController.text != currentUser.value?.phoneNo ||
            passwordController.text != currentUser.value?.password;
  }

  Future<void> updateUserData() async {
    if (isDataChanged.value) {
      UserModel? currentUser = GlobalModel.instance.authenticatedUser.value;
      String userEmail = currentUser?.email ?? '';

      if (userEmail.isEmpty) {
        Get.snackbar(
          'Thông báo',
          'Đã xảy ra lỗi. Vui lòng thử lại sau!',
          colorText: AppColor.primaryColor,
          backgroundColor: const Color(0xffDDE6ED),
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Get.snackbar(
          'Thông báo',
          'Đã xảy ra lỗi. Vui lòng thử lại sau!',
          colorText: AppColor.primaryColor,
          backgroundColor: const Color(0xffDDE6ED),
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      String documentId = querySnapshot.docs.first.id;
      var docRef =
          FirebaseFirestore.instance.collection('users').doc(documentId);

      await docRef.update({
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phoneNo': phoneController.text,
        'password': passwordController.text,
      }).then((_) async {
        UserModel updatedUser = UserModel(
          fullname: fullNameController.text,
          email: emailController.text,
          phoneNo: phoneController.text,
          password: passwordController.text,
        );

        GlobalModel.instance.setAuthenticatedUser(updatedUser);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String updatedUserData = jsonEncode(updatedUser.toJson());
        await prefs.setString('userData', updatedUserData);

        Get.snackbar(
          'Thông báo',
          'Cập nhật người dùng thành công!',
          colorText: AppColor.primaryColor,
          backgroundColor: const Color(0xffDDE6ED),
          snackPosition: SnackPosition.TOP,
        );
      }).catchError((error) {
        Get.snackbar(
          'Thông báo',
          'Đã xảy ra lỗi. Vui lòng thử lại sau!',
          colorText: AppColor.primaryColor,
          backgroundColor: const Color(0xffDDE6ED),
          snackPosition: SnackPosition.TOP,
        );
      });
    }
  }
}
