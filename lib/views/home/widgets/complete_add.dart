import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:lottie/lottie.dart';

class CompleteAdd extends StatelessWidget {
  const CompleteAdd({super.key, required this.onDone});
  final Function() onDone;
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
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
          'Phòng khách đã được thêm',
          style: AppStyle.appBarText.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 26),
        MyButton(text: 'Hoàn tất', onTap: onDone)
      ],
    );
  }
}
