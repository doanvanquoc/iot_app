import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<AddRoomViewModel>();
    return TextFormField(
      controller: controller,
      onChanged: (value) => viewModel.setRoomName(value),
      validator: (value) {
        if (value!.isEmpty) return 'Vui lòng nhập tên khu vực';
        return null;
      },
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
