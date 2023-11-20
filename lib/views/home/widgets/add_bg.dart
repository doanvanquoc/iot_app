import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/home_view_model/add_room_viewmodel.dart';

class AddBackground extends StatelessWidget {
  const AddBackground(
      {super.key,
      required this.onNext,
      required this.onBack,
      required this.onCancel});
  final Function() onNext;
  final Function() onBack;
  final Function() onCancel;
  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<AddRoomViewModel>();
    if (viewModel.selectedImgUrl.isEmpty) {
      viewModel.selectedImgUrl.value = viewModel.imgs[0];
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Text(
          'Ảnh nền',
          style: AppStyle.appBarText.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: viewModel.imgs.length,
          itemBuilder: (_, index) {
            String imgUrl = viewModel.imgs[index];
            return Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      viewModel.setImgUrl(imgUrl);
                      log(viewModel.selectedImgUrl.value.toString());
                      viewModel.onSelectedChange(imgUrl);
                      log(viewModel.selectedImgUrl.value.toString());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(viewModel.imgs[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => imgUrl == viewModel.selectedImgUrl.value
                    ? const Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(
                          Icons.check_circle,
                          color: AppColor.primaryColor,
                        ),
                      )
                    : const SizedBox())
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        MyButton(
          text: 'Tiếp tục',
          onTap: onNext,
        ),
        const SizedBox(height: 8),
        MyButton(
          text: 'Trở về',
          textStyle: AppStyle.buttonText.copyWith(color: AppColor.primaryColor),
          onTap: onBack,
          bgColor: Colors.transparent,
        ),
      ],
    );
  }
}
