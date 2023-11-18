import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/image.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.red,
              ),
              height: 160,
            ),
            const Positioned(
              top: 20,
              left: 24,
              child: Text('Phòng khách', style: AppStyle.onImagePrimaryText),
            ),
            const Positioned(
              top: 42,
              left: 24,
              child: Text('2/3 đang bật', style: AppStyle.onImageSecondaryText),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                child: Image.asset(
                  'assets/images/led.png',
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                child: Image.asset(
                  'assets/images/led.png',
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                child: Image.asset(
                  'assets/images/led.png',
                  width: 30,
                  height: 30,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
