import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/view_models/edit_user_view_model.dart';
import 'package:iot_app/view_models/notification_view_model.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_add.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_option.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_sucessfull.dart';

class DeviceViewModel extends GetxController {
  var currentIndex = 0.obs;
  var selectedIndex = 0.obs;
  var nameDevice = "".obs;
  RxList<Device> devicesById = <Device>[].obs;
  final notiViewModel = Get.put(NotificationViewModel());
  RxInt lightValue = 0.obs;

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

  void fetchRealtimeData() async {
    String homeId = await Get.find<AuthenticationViewModel>().getHomeId();
    database.ref().child('$homeId/device').onValue.listen((event) {
      final deviceData = event.snapshot.value;
      if (deviceData is List<dynamic>) {
        devices.value = deviceData
            .where((item) => item != null)
            .map((json) => Device.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      }
      devices.firstWhereOrNull((element) => element.id == 3)?.state =
          devices.firstWhereOrNull((element) => element.id == 4)?.state ??
              false;
      // else if (deviceData is Map<dynamic, dynamic>) {
      //   devices.value = deviceData.values
      //       .where((item) => item != null)
      //       .map((json) => Device.fromJson(Map<String, dynamic>.from(json)))
      //       .toList();
      // }
      lightValue.value = devices
              .firstWhereOrNull((element) => element.lightValue != null)
              ?.lightValue! ??
          0;
      devices.firstWhereOrNull((element) => element.lightValue != null)?.state =
          lightValue.value <= 20;

      database
          .ref('$homeId/device')
          .child(
              '${devices.indexOf(devices.firstWhereOrNull((element) => element.lightValue != null)) + 1}')
          .update({
        'state': devices
            .firstWhereOrNull((element) => element.lightValue != null)
            ?.state
      });
    });
  }

  void onTapRoom(int index) {
    selectedIndex.value = index;
  }

  Future<void> onHandelSwitch(bool pres, int id) async {
    String action1 = devices.singleWhere((element) => element.id == id).id == 7
        ? "Mở"
        : "Bật";
    String action2 = devices.singleWhere((element) => element.id == id).id == 7
        ? "Đóng"
        : "Tắt";
    String homeId = await Get.find<AuthenticationViewModel>().getHomeId();
    if (devices.singleWhere((element) => element.id == id).lightValue == null) {
      String user = Get.find<EditUserViewModel>().fullNameController.text;
      var deviceIndex = devices.indexWhere((d) => d.id == id);
      if (deviceIndex != -1) {
        devices[deviceIndex].state = pres;
        if (deviceIndex == 2 || deviceIndex == 3) {
          devices[3].state = pres;
          devices[4].state = pres;
          database.ref('$homeId/device').child('${3}').update({'state': pres});
          database.ref('$homeId/device').child('${4}').update({'state': pres});
          String noti1 = devices[2].state
              ? "$action1 ${devices[2].name}"
              : "$action2 ${devices[2].name}";

          String noti2 = devices[3].state
              ? "$action1 ${devices[3].name}"
              : "$action2 ${devices[3].name}";
          log(noti1);
          log(noti2);
          await notiViewModel.addNotification(noti1, user);
          await notiViewModel.addNotification(noti2, user);
        } else {
          database
              .ref('$homeId/device')
              .child('${deviceIndex + 1}')
              .update({'state': pres});
          String noti = devices[deviceIndex].state
              ? "$action1 ${devices[deviceIndex].name}"
              : "$action2 ${devices[deviceIndex].name}";
          // notiViewModel.addNoti(DateTime.now(), noti);

          notiViewModel.addNotification(noti, user);
        }

        update();
      }
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

  onChangeLightValue(int value) {
    lightValue.value = value;
    devices.singleWhere((element) => element.lightValue != null).state =
        lightValue <= 20;
  }
}
