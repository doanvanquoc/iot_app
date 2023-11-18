import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';
import 'package:iot_app/views/home/widgets/room_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addRoomViewModel = Get.put(AddRoomController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Trang chủ', style: AppStyle.appBarText),
        actions: [
          IconButton(
            onPressed: addRoomViewModel.showModalBottomSheetAction,
            icon: const Icon(
              Icons.add_circle,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          itemCount: addRoomViewModel.rooms.length,
          itemBuilder: (_, index) {
            return RoomItem(room: addRoomViewModel.rooms[index]);
          },
        ),
      ),
    );
  }
}
