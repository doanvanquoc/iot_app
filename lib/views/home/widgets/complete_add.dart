import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';
import 'package:lottie/lottie.dart';

class CompleteAdd extends StatelessWidget {
  const CompleteAdd({super.key, required this.onDone, required this.onCancel});
  final Function() onDone;
  final Function() onCancel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onCancel,
              icon: const Icon(
                Icons.cancel,
                color: AppColor.secondaryColor,
              ),
            )
          ],
        ),
        Lottie.asset(
          'assets/lotties/checked.json',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 30),
        Text(
          '${Get.find<AddRoomViewModel>().roomName} đã được thêm',
          style: AppStyle.appBarText.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 26),
        MyButton(text: 'Hoàn tất', onTap: onDone)
      ],
    );
  }
}
