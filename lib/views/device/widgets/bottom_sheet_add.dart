import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';
import 'package:iot_app/views/device/widgets/textformfield_add.dart';

class BottomSheetAdd extends StatelessWidget {
  BottomSheetAdd({super.key, required this.onNext, required this.onCanel});
  final Function() onNext;
  final Function() onCanel;
  final frmKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DeviceViewModel deviceViewModel = Get.find();
    final textController = TextEditingController();
    textController.text = deviceViewModel.nameDevice.value;
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Form(
              key: frmKey,
              child: Column(
                children: [
                  TextFormFieldAdd(controller: textController),
                  const SizedBox(height: 30),
                  MyButton(
                      text: "Tiếp tục",
                      onTap: () {
                        if (frmKey.currentState!.validate()) {
                          onNext();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
