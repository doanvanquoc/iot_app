import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_bottom_nav_bar.dart';
import 'package:iot_app/view_models/area_view_model.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';
import 'package:iot_app/views/home/widgets/room_item.dart';
import 'package:iot_app/views/room/living_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final areaViewModel = Get.put(AreaViewModel());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: const Text('Trang chủ', style: AppStyle.appBarText),
        // actions: [
        //   IconButton(
        //     onPressed: viewModel.showModalBottomSheetAction,
        //     icon: const Icon(
        //       Icons.add_circle,
        //       color: AppColor.secondaryColor,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Obx(
            () => Card(
              margin: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'LCD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Tổng số thiết bị: ${Get.find<DeviceViewModel>().devices.length}'),
                        Text(
                            'Số thiết bị đang hoạt động: ${Get.find<DeviceViewModel>().devices.where((element) => element.state).length}'),
                        Text(
                            'Độ sáng hiện tại: ${Get.find<DeviceViewModel>().devices.firstWhereOrNull((e) => e.id == 5)?.lightValue ?? 0}/100')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  itemCount: areaViewModel.areas.length,
                  itemBuilder: (_, index) {
                    return AreaItem(
                      area: areaViewModel.areas[index],
                      onTap: () => Get.to(
                          AreaDetailScreen(area: areaViewModel.areas[index])),
                    );
                  },
                ),
              )),
        ],
      ),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
