import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class BottomSheetSucessfull extends StatelessWidget {
  BottomSheetSucessfull({
    super.key,
    required this.onDone,
    required this.onCanel,
  });
  Function() onDone;
  Function() onCanel;
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
              Center(
                child: ClipOval(
                  child: Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border:
                            Border.all(color: AppColor.primaryColor, width: 6)),
                    child: const Icon(
                      Icons.done_rounded,
                      color: AppColor.primaryColor,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                  child: Text(
                '${deviceViewModel.lstNameRoom[deviceViewModel.selectedIndex.value - 1]} đã được thêm',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
              const SizedBox(height: 25),
              MyButton(
                text: "Hoàn thành",
                onTap: () {
                  onDone();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
