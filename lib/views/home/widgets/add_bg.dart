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
    final addRoomViewModel = Get.find<AddRoomViewModel>();
    List<String> imgs = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
      'assets/images/bg5.png',
      'assets/images/bg6.png',
    ];
    return SingleChildScrollView(
      child: Column(
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
          GetBuilder<AddRoomViewModel>(builder: (context) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: context.imgs.length,
              itemBuilder: (_, index) {
                String imgUrl = context.imgs[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          addRoomViewModel.setImgUrl(imgUrl);
                          addRoomViewModel.onSelectedChange(imgUrl);
                          log(addRoomViewModel.selectedImgUrl.value.toString());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(imgs[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (imgUrl == context.selectedImgUrl.value)
                      const Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(
                          Icons.check_circle,
                          color: AppColor.primaryColor,
                        ),
                      ),
                  ],
                );
              },
            );
          }),
          const SizedBox(height: 16),
          MyButton(
              text: 'Tiếp tục',
              onTap: () {
                if (addRoomViewModel.selectedImgUrl.isEmpty) {
                  Get.showSnackbar(const GetSnackBar(
                    titleText: Text('Thông báo', style: AppStyle.appBarText),
                    messageText: Text(
                      'Vui lòng chọn ảnh nền',
                      style: AppStyle.onCardPrimaryText,
                    ),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(8),
                    duration: Duration(seconds: 1),
                    backgroundColor: AppColor.backgroundColor,
                    borderRadius: 16,
                    snackPosition: SnackPosition.TOP,
                  ));
                } else {
                  onNext();
                }
              }),
          const SizedBox(height: 8),
          MyButton(
            text: 'Trở về',
            textStyle: AppStyle.buttonText.copyWith(color: AppColor.primaryColor),
            onTap: onBack,
            bgColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
