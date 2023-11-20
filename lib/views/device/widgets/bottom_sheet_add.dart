import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class BottomSheetAdd extends StatelessWidget {
  const BottomSheetAdd({super.key, required this.onNext, required this.onCanel});
  final Function() onNext;
  final Function() onCanel;

  @override
  Widget build(BuildContext context) {
    DeviceViewModel deviceViewModel = Get.find();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
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
                    onTap: Get.back,
                    child: ClipOval(
                      child: Container(
                        color: Colors.black,
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                "Tên thiết bị",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                onChanged: (value) => deviceViewModel.setNameDevice(value),
                style: const TextStyle(height: 1),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: AppColor.primaryColor, width: 2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: AppColor.primaryColor, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: AppColor.primaryColor, width: 2)),
                  hintText: "Tên thiết bị",
                ),
              ),
              const SizedBox(height: 30),
              MyButton(
                  text: "Tiếp tục",
                  onTap: () {
                    if (deviceViewModel.nameDevice.isEmpty) {
                      Get.showSnackbar(const GetSnackBar(
                        titleText:
                            Text('Thông báo', style: AppStyle.appBarText),
                        messageText: Text(
                          'Vui lòng nhập tên thiết bị',
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
            ],
          ),
        ),
      ),
    );
  }
}
