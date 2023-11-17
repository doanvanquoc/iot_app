import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';

class OTPFieldController extends StatelessWidget {
  OTPFieldController({Key? key}) : super(key: key);

  final AuthenticationViewModel otpField = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        var controller = otpField.otpControllers[index];
        return SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            controller: controller,
            autofocus: index == 0,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              otpField.onOTPChanged(value, index, context);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }),
    );
  }
}
