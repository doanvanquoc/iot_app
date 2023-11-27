import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/views/device/device_screen.dart';
import 'package:iot_app/views/home/home_screen.dart';

class NavViewModel extends GetxController {
  List<Widget> screens = [];
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    screens = [const HomeScreen(), const DeviceScreen()];
    super.onInit();
  }

  void onChangeTab(value) {
    log(value.toString());
    currentIndex.value = value;
  }
}
