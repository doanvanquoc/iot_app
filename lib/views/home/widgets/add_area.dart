import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';

class AddArea extends StatelessWidget {
  const AddArea({super.key, required this.onNext, required this.onCancel});
  final Function() onNext;
  final Function() onCancel;
  @override
  Widget build(BuildContext context) {
    final addRoomViewModel = Get.find<AddRoomController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Text('Tên khu vực',
            style: AppStyle.appBarText.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 32),
        TextField(
          onChanged: (value) => addRoomViewModel.setRoomName(value),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 46),
        MyButton(text: 'Tiếp tục', onTap: onNext)
      ],
    );
  }
}
