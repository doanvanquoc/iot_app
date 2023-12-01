import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavViewModel viewModel = Get.put(NavViewModel());
    return Obx(() {
      return viewModel.screens[viewModel.currentIndex.value];
    });
  }
}
