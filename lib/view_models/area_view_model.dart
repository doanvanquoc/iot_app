import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class AreaViewModel extends GetxController {
  final deviceViewModel = Get.put(DeviceViewModel());
  RxList<Area> areas = <Area>[].obs;
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
      }

      for (var area in areas) {
        getAreaDevices(area);
      }
    });
  }

  void getAreaDevices(Area area) {
    FirebaseDatabase.instance
        .ref()
        .child('myhome/device')
        .onValue
        .listen((event) {
      final deviceData = event.snapshot.value;
      RxList<Device> devices = <Device>[].obs;
      if (deviceData is List<dynamic>) {
        devices.value = deviceData
            .where((item) => item != null)
            .map((json) => Device.fromJson(Map<String, dynamic>.from(json)))
            .where((element) => element.areaId == area.id)
            .toList();
      }
      area.devices = devices;
      update();
    });
  }

  @override
  void onInit() {
    getAreas();
    super.onInit();
  }
}
