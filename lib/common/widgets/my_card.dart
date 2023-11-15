import 'package:flutter/cupertino.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';

class MyCard extends StatelessWidget {
  final String deviceName;
  final String area;
  final IconData icon;
  const MyCard(
      {super.key,
      required this.deviceName,
      required this.area,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 40),
              const SizedBox(width: 100),
              CupertinoSwitch(
                  value: true,
                  onChanged: (active) {},
                  activeColor: AppColor.primaryColor),
              // Switch(
              //   value: true,
              //   onChanged: (value) {},
              //   activeColor: AppColor.primaryColor,
              // )
            ],
          ),
          const SizedBox(height: 16),
          Text(deviceName, style: AppStyle.onCardPrimaryText),
          Text(area, style: AppStyle.onCardSecondaryText),
        ],
      ),
    );
  }
}
