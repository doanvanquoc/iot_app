import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_card.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/view_models/detail_room_model/view.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class Living_Item extends StatelessWidget {
  Living_Item({super.key, required this.area});
  final Area area;
  bool isswit = false;

  @override
  Widget build(BuildContext context) {
    viewModel view = Get.put(viewModel());
    final deviceViewModel = Get.put(DeviceViewModel());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage(area.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 160,
            ),
            Positioned(
              top: 20,
              left: 24,
              child: Text(area.name, style: AppStyle.onImagePrimaryText),
            ),
            const Positioned(
              top: 42,
              left: 24,
              child: Text(
                '${3} / ${3} đang bật',
                style: AppStyle.onImageSecondaryText,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Thiết Bị",
              style: TextStyle(
                color: Color(0xff484D51),
                fontSize: 18,
              )),
        ),
        Obx(
          () => GridView.builder(
            shrinkWrap: true,
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
      ],
    );
  }
}
