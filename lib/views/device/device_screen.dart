import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_bottom_nav_bar.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

import '../../common/widgets/my_card.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceViewModel = Get.put(DeviceViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thiết bị',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(3.5),
                color: AppColor.secondaryColor,
                child: InkWell(
                  onTap: () {
                    deviceViewModel.showModalBottomSheetAction();
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2,
            ),
            itemCount: deviceViewModel.devices.length,
            itemBuilder: (_, int index) {
              return MyCard(
                device: deviceViewModel.devices[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
