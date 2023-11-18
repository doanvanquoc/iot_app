import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/models/room.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.room});
  final Room room;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage(room.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 160,
            ),
            Positioned(
              top: 20,
              left: 24,
              child: Text(room.name, style: AppStyle.onImagePrimaryText),
            ),
            Positioned(
              top: 42,
              left: 24,
              child: Text(
                '${room.turningDevices} / ${room.totalDevices} đang bật',
                style: AppStyle.onImageSecondaryText,
              ),
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
