import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_bottom_nav_bar.dart';
import 'package:iot_app/view_models/area_view_model.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';
import 'package:iot_app/views/home/widgets/room_item.dart';
import 'package:iot_app/views/room/living_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(AddRoomViewModel());
    final areaViewModel = Get.put(AreaViewModel());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Trang chủ', style: AppStyle.appBarText),
        actions: [
          IconButton(
            onPressed: viewModel.showModalBottomSheetAction,
            icon: const Icon(
              Icons.add_circle,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
      body: GetBuilder<AreaViewModel>(
        builder: (controller) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          itemCount: areaViewModel.areas.length,
          itemBuilder: (_, index) {
            return AreaItem(
              area: areaViewModel.areas[index],
              onTap: () =>
                  Get.to(AreaDetailScreen(area: areaViewModel.areas[index])),
            );
          },
        ),
      ),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
