import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/view_models/navigation_view_model.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(NavViewModel());
    return Obx(() => viewModel.screens[viewModel.currentIndex.value]);
  }
}
