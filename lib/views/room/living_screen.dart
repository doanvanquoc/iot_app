import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';
import 'package:iot_app/views/home/widgets/living_room.dart';

class AreaDetailScreen extends StatelessWidget {
  const AreaDetailScreen({super.key, required this.area});
  final Area area;

  @override
  Widget build(BuildContext context) {
    final deviceViewModel = Get.put(DeviceViewModel());
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(area.name, style: AppStyle.appBarText),
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
        child: AreaDetailItem(area: area),
      ),
    );
  }
}
