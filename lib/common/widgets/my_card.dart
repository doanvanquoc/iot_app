import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/view_models/area_view_model.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.device});
  final Device device;

  @override
  Widget build(BuildContext context) {
    DeviceViewModel deviceViewModel = Get.find();

    AreaViewModel areaViewModel = Get.put(AreaViewModel());
    int? lightValue = device.lightValue;

    String areaName = areaViewModel.areas
        .firstWhere((area) => area.id == device.areaId,
            orElse: () =>
                Area(id: -1, name: 'Unknown', imgUrl: '', devices: [], des: ''))
        .name;

    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<DeviceViewModel>(builder: (_) {
            log(lightValue.toString());
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  (device.id == 7) ? Icons.door_sliding : device.icon,
                  size: 40,
                  color: deviceViewModel.devices[device.id - 1].state
                      ? AppColor.primaryColor
                      : Colors.black,
                ), // Ensure the icon is handled correctly
                CupertinoSwitch(
                    value: lightValue == null
                        ? deviceViewModel.devices[device.id - 1].state
                        : lightValue <= 20,
                    onChanged: (value) =>
                        deviceViewModel.onHandelSwitch(value, device.id),
                    activeColor: AppColor.primaryColor),
              ],
            );
          }),
          const SizedBox(height: 16),
          Expanded(
              child: Text(
            device.name,
            style: AppStyle.onCardPrimaryText,
            overflow: TextOverflow.ellipsis,
          )),
          Text(
            areaName,
            style: AppStyle.onCardSecondaryText,
          ), // Display area name
        ],
      ),
    );
  }
}
