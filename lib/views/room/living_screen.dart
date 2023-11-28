import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/models/room.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';
import 'package:iot_app/views/home/widgets/living_room.dart';

class living_Screen extends StatelessWidget {
  const living_Screen({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    final deviceViewModel = Get.put(DeviceViewModel());
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(room.name, style: AppStyle.appBarText),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: deviceViewModel.showModalBottomSheetAction,
            icon: const Icon(
              Icons.add_circle,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Living_Item(room: room),
      ),
    );
  }
}
