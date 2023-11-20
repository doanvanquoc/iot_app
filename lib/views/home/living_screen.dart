import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_bottom_nav_bar.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';
import 'package:iot_app/views/home/widgets/living_room.dart';


class living_Screen extends StatelessWidget {
  const living_Screen({super.key});
  

  @override
  Widget build(BuildContext context) {
       final addRoomViewModel = Get.put(AddRoomViewModel());
    return  Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
         title: const Text('Phòng Khách', style: AppStyle.appBarText),
         centerTitle: true,
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
      body: 
      Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          itemCount: addRoomViewModel.rooms.length,
          itemBuilder: (_, index) {
            return Living_Item(room:addRoomViewModel.rooms[index],);
          },
        ),
      ),
       bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}