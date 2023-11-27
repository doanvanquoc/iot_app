import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_add.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_option.dart';
import 'package:iot_app/views/device/widgets/bottom_sheet_sucessfull.dart';

class DeviceViewModel extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> lstModel = [];
  var checkStateDevice = false.obs;

  var nameDevice = "".obs;

  var selectedIndex = 0.obs;

  List<String> lstNameRoom = [];

  @override
  void onInit() {
    lstModel = [
      BottomSheetAdd(onNext: onNext, onCanel: onBack),
      BottomSheetOption(onNext: onNext, onBack: onBack, onCanel: onCanel),
      BottomSheetSucessfull(onDone: onDone, onCanel: onCanel)
    ];
    lstNameRoom = [
      "Phòng khách",
      "Phòng ăn",
      "Phòng bếp",
      "Phòng ngủ 1",
      "Phòng ngủ 2",
      "Phòng WC",
      "Ngoài trời",
    ];
  }

  void onTapRoom(index) {
    selectedIndex.value = index;
  }

  void onHandelSwitch(pres) {
    checkStateDevice.value = pres;
  }

  void onNext() {
    currentIndex++;
    Get.back();
    showModalBottomSheetAction();
  }

  void onBack() {
    currentIndex--;
    Get.back();
    showModalBottomSheetAction();
  }

  void onCanel() {
    currentIndex.value = 0;
    selectedIndex.value = 0;
    nameDevice.value = "";
    Get.back();
  }

  void onDone() {
    currentIndex.value = 0;
    selectedIndex.value = 0;
    nameDevice.value = "";
    Get.back();
  }

  void setNameDevice(String name) {
    nameDevice.value = name;
  }

  void showModalBottomSheetAction() {
    print(currentIndex.value);
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
