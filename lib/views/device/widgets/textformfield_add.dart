import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class TextFormFieldAdd extends StatelessWidget {
  const TextFormFieldAdd({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    DeviceViewModel deviceViewModel = Get.find();
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập tên thiết bị";
        }
        return null;
      },
      onChanged: (value) => deviceViewModel.setNameDevice(value),
      style: const TextStyle(height: 1),
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
        hintText: "Tên thiết bị",
      ),
    );
  }
}
