import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';
import 'package:iot_app/views/device/widgets/area_item.dart';

class BottomSheetOption extends StatelessWidget {
  const BottomSheetOption({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onCanel,
  });
  final Function() onNext;
  final Function() onBack;
  final Function() onCanel;

  @override
  Widget build(BuildContext context) {
    DeviceViewModel deviceViewModel = Get.find();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.48,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: onCanel,
                    child: ClipOval(
                      child: Container(
                        color: Colors.black,
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Center(
                child: Text(
                  "Chọn khu vực",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AreaItem(index: 1),
                      SizedBox(width: 16),
                      AreaItem(index: 2),
                      SizedBox(width: 16),
                      AreaItem(index: 3),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AreaItem(index: 4),
                      SizedBox(width: 16),
                      AreaItem(index: 5),
                      SizedBox(width: 16),
                      AreaItem(index: 6),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [AreaItem(index: 7)],
              ),
              const SizedBox(height: 40),
              MyButton(
                  text: "Tiếp tục",
                  onTap: () {
                    if (deviceViewModel.selectedIndex.value != 0) {
                      onNext();
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        titleText:
                            Text('Thông báo', style: AppStyle.appBarText),
                        messageText: Text(
                          'Vui lòng chọn tên phòng',
                          style: AppStyle.onCardPrimaryText,
                        ),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(8),
                        duration: Duration(seconds: 1),
                        backgroundColor: AppColor.backgroundColor,
                        borderRadius: 16,
                        snackPosition: SnackPosition.TOP,
                      ));
                    }
                  }),
              const SizedBox(height: 20),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onBack();
                  },
                  child: const Text("Trở về",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
