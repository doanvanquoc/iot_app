import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/models/user.dart';
import 'package:iot_app/view_models/edit_user_view_model.dart';
import 'package:iot_app/view_models/notification_view_model.dart';
import 'package:iot_app/views/device/device_screen.dart';
import 'package:iot_app/views/home/home_screen.dart';
import 'package:iot_app/views/user/user_screen.dart';

class NavViewModel extends GetxController {
  RxInt currentIndex = 0.obs;
  final screens = <Widget>[].obs;
  UserModel? get authenticatedUser =>
      GlobalModel.instance.authenticatedUser.value;

  @override
  void onInit() {
    super.onInit();

    ever(GlobalModel.instance.obs, (_) {
      screens.value = [
        const HomeScreen(),
        const DeviceScreen(),
        UserScreen(user: authenticatedUser),
      ];
      update();
    });

    screens.value = [
      const HomeScreen(),
      const DeviceScreen(),
      UserScreen(user: authenticatedUser),
    ];
  }

  void onChangeTab(int value) {
    currentIndex.value = value;
  }
}

class GlobalModel extends GetxController {
  static GlobalModel instance = Get.find();
  var authenticatedUser = Rxn<UserModel?>();

  void setAuthenticatedUser(UserModel user) {
    authenticatedUser.value = user;
    updateEditUserViewModel();
    update();
    Future.delayed(const Duration(seconds: 2), () {
      NotificationViewModel().listenToFirebellState();
    });
  }

  void clearAuthenticatedUser() {
    authenticatedUser.value = null;
    update();
  }

  void updateEditUserViewModel() {
    final EditUserViewModel viewModel = Get.put(EditUserViewModel());
    viewModel.fullNameController.text = authenticatedUser.value?.fullname ?? '';
    viewModel.emailController.text = authenticatedUser.value?.email ?? '';
    viewModel.phoneController.text = authenticatedUser.value?.phoneNo ?? '';
    viewModel.passwordController.text = authenticatedUser.value?.password ?? '';
  }
}
