import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/view_models/area_view_model.dart';
import 'package:iot_app/views/home/widgets/add_area.dart';
import 'package:iot_app/views/home/widgets/add_bg.dart';
import 'package:iot_app/views/home/widgets/complete_add.dart';

class AddRoomViewModel extends GetxController {
  final areaViewModel = Get.put(AreaViewModel());
  RxInt currentIndex = 0.obs;
  List<Widget> lstShowModal = [];
  RxList<Area> areas = <Area>[].obs;
  RxString roomName = ''.obs;
  RxString imgUrl = ''.obs;

  RxList<String> imgs = [
    'assets/images/bg1.png',
    'assets/images/bg2.png',
    'assets/images/bg3.png',
    'assets/images/bg4.png',
    'assets/images/bg5.png',
    'assets/images/bg6.png',
  ].obs;

  var selectedImgUrl = ''.obs;

  @override
  void onInit() {
    lstShowModal = [
      AddArea(onNext: onNext, onCancel: onCancel),
      AddBackground(onNext: onNext, onBack: onBack, onCancel: onCancel),
      CompleteAdd(onDone: onDone, onCancel: onCancel)
    ];

    areas = areaViewModel.areas;
    selectedImgUrl.value = imgs[0];
    super.onInit();
  }

  void onNext() {
    currentIndex.value++;
    Get.back();
    showModalBottomSheetAction();
  }

  void onBack() {
    Get.back();
    currentIndex.value--;
    showModalBottomSheetAction();
  }

  void onDone() {
    // currentIndex.value = 0;
    // log(imgUrl.toString());
    // rooms.add(Room(
    //     name: roomName.value,
    //     totalDevices: 0,
    //     turningDevices: 0,
    //     imgUrl: imgUrl.value));
    // Get.back();
    // reset();
  }

  void onCancel() {
    currentIndex.value = 0;
    reset();
    Get.back();
  }

  void showModalBottomSheetAction() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context!,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: lstShowModal[currentIndex.value],
            ),
          );
        });
  }

  void setRoomName(String name) {
    roomName.value = name;
  }

  void setImgUrl(String url) {
    imgUrl.value = url;
  }

  void reset() {
    selectedImgUrl.value = '';
    roomName.value = '';
    imgUrl.value = '';
  }

  void onSelectedChange(String url) {
    selectedImgUrl.value = url;
  }
}
