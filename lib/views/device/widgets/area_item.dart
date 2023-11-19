import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class AreaItem extends StatelessWidget {
  AreaItem({
    super.key,
    required this.index,
  });
  int index;

  @override
  Widget build(BuildContext context) {
    DeviceViewModel deviceViewModel = Get.find();
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          deviceViewModel.onTapRoom(index);
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: deviceViewModel.selectedIndex.value == index
                  ? AppColor.backgroundColor
                  : Colors.white,
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Text(
              deviceViewModel.lstNameRoom[index - 1],
              style: const TextStyle(fontSize: 15),
            )),
          ),
        ),
      ),
    );
  }
}
