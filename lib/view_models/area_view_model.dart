import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class AreaViewModel extends GetxController {
  final deviceViewModel = Get.put(DeviceViewModel());
  RxList<Area> areas = <Area>[].obs;
  List<Device> devices = [];
  void getAreas() {
    FirebaseDatabase.instance
        .ref()
        .child('myhome/area')
        .onValue
        .listen((event) {
      final areaData = event.snapshot.value as List<dynamic>?;
      if (areaData != null) {
        areas.value = areaData
            .where((item) => item != null)
            .map((json) => Area.fromJson(Map<String, dynamic>.from(json)))
            .toList();

        for (var area in areas) {
          area.devices = deviceViewModel.getDevicesByAreaId(area.id);
        }
      }
      log(areas.toString());
    });
  }

  @override
  void onInit() {
    getAreas();
    super.onInit();
  }
}
