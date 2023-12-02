import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_add.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_option.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_sucessfull.dart';

class DeviceViewModel extends GetxController {
  var currentIndex = 0.obs;
  var selectedIndex = 0.obs;
  var nameDevice = "".obs;

  List<Widget> lstModel = [];
  List<String> lstNameRoom = [];

  void initializeBottomSheets() {
    lstModel = [
      BottomSheetAdd(onNext: onNext, onCanel: onBack),
      BottomSheetOption(onNext: onNext, onBack: onBack, onCanel: onCanel),
      BottomSheetSucessfull(onDone: onDone, onCanel: onCanel)
    ];
  }

  RxList<Device> devices = <Device>[].obs;
  RxList<Area> areas = <Area>[].obs;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void onInit() {
    super.onInit();
    fetchRealtimeData();
  }

  void fetchRealtimeData() {
    database.ref().child('myhome/area').onValue.listen((event) {
      final areaData = event.snapshot.value as List<dynamic>?;
      if (areaData != null) {
        areas.value = areaData
            .where((item) => item != null)
            .map((json) => Area.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      }
    });

    database.ref().child('myhome/device').onValue.listen((event) {
      final deviceData = event.snapshot.value;
      if (deviceData is List<dynamic>) {
        devices.value = deviceData
            .where((item) => item != null)
            .map((json) => Device.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } else if (deviceData is Map<dynamic, dynamic>) {
        devices.value = deviceData.values
            .where((item) => item != null)
            .map((json) => Device.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      }
    });
  }

  void onTapRoom(int index) {
    selectedIndex.value = index;
  }

  void onHandelSwitch(bool pres, int id) {
    var deviceIndex = devices.indexWhere((d) => d.id == id);
    if (deviceIndex != -1) {
      devices[deviceIndex].state = pres;

      database
          .ref('myhome/device')
          .child('${deviceIndex + 1}')
          .update({'state': pres});

      update();
    }
  }

  void onNext() {
    currentIndex++;
    showModalBottomSheetAction();
  }

  void onBack() {
    currentIndex--;
    showModalBottomSheetAction();
  }

  void onCanel() {
    resetForm();
  }

  void onDone() {
    int selectedAreaId = areas[selectedIndex.value].id;

    devices.add(Device(
        id: devices.length + 1,
        name: nameDevice.value,
        areaId: selectedAreaId,
        icon: Icons.light,
        state: false));
    resetForm();
  }

  void setNameDevice(String name) {
    nameDevice.value = name;
  }

  void resetForm() {
    currentIndex.value = 0;
    selectedIndex.value = 0;
    nameDevice.value = "";
    Get.back();
  }

  void showModalBottomSheetAction() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColor.backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
        context: Get.context!,
        builder: (BuildContext content) {
          return Padding(
            padding: MediaQuery.of(Get.context!).viewInsets,
            child: lstModel[currentIndex.value],
          );
        });
  }
}
